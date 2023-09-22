''' 
Este código é uma tentativa extra de manipular tabelas utilizando a linguagem python.
No caso, podemos simular uma Stored Procedure, realizando updates de tabela a partir de condições específicas.
Abaixo, podemos observar uma programação orientada a objeto que aplica percentual de variação nos preços e atualiza o estado dos produtos.
'''
# Importação de bibliotecas
# Será utilizado o pandas para manipulação de tabela e o datetime para datas e horários
import pandas as pd
from datetime import datetime


class StoredProcedure:

    # Definições de inicialização da classe
    def __init__(self, table_name, execution_date = datetime.today(), percent_variation:float = 0.0, end_day:str = '20:00:00') -> None:
        self.table_name = table_name
        self.execution_date = execution_date
        self.percent_variation = percent_variation
        self.end_day = datetime.strptime(end_day, '%H:%M:%S').hour

    # Simulando uma conexão. O arquivo csv poderia ser substituido por uma tabela de conexão com um banco.
    def connect_table(self) -> pd.DataFrame:
        df = pd.read_csv(f'{self.table_name}.csv')
        return df
    
    # Aplicação de percentual para alteração de preços, simulando variações ao longo do tempo
    def percent_aplication(self, df) -> pd.DataFrame:
        df['price'] = df['price'].apply(lambda x: round(x+(x*self.percent_variation),2))
        return df
    
    # Função que compara a data corrente com a data de parâmetro. Será usada para validar a coluna 'is_active'
    @staticmethod
    def state_validation(end_date):
        hoje = datetime.now()
        if end_date <= hoje:
            return False 
        else:
            return True

    # Recebe a função validadora acima e aplica alteração do status na coluna 'is_active' a partir da sua data de validade ('end_date')
    def state_aplication(self, df) -> pd.DataFrame:
        df['end_date'] = pd.to_datetime(df['end_date'])
        df['is_active'] = df['end_date'].apply(self.state_validation)
        return df
    
    # Execução das funções anteriores, validando o horário local para aplicar as mudanças na tabela histórico
    def run(self):
        if datetime.now().hour >= self.end_day:
            df = self.connect_table()
            df = self.percent_aplication(df)
            df = self.state_aplication(df)
            return df.to_csv('item_historic.csv', index=False)
        else:
            return print(f'A tabela só poderá ser atualizada após as {self.end_day}:00:00 horas')


if __name__ == '__main__':
    # Os parâmetros 'table_name' e 'percent_variation' podem ser alterados conforme necessidade
    tabela_itens = StoredProcedure(table_name = 'item', percent_variation= 0.10)
    tabela_itens.run()

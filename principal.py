
#Bridgte é uma ponte 

from PySide6.QtCore import QObject, Slot
from pathlib import Path
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtGui import QGuiApplication

from httpx import get 



class Ponte(QObject):
    #Tem que colocar umm slot para poder fazer a conexão com o arquivo qml
    @Slot(str,result=list)
    def pegar_pokemon(self,pokemon_id):
        image_path = Path("pokemon_image.png")
        try:
            if image_path.exists():
                print("Deletando Imagem")
                image_path.unlink()
             #Para pegar a imagem que está em formato json   
             # A partir do Json você consegue acessar qualquer coisa dele
            response = get(f"https://pokeapi.co/api/v2/pokemon/{pokemon_id}").json()
            #Para se conectar na imagem que tá no json
            image_url = response['sprites']['other']['home']['front_default']
            #Para pegar o conteudo da imagem
            image_content = get(image_url).content
            
            with open('pokemon_image.png', 'wb') as poke_image:
                poke_image.write(image_content)
                #Para escrever isso no arquivo 
                #imagem_content é o conteudo da imag-em 
               
            
        except Exception as e:
            print(e)
        finally:
            return str(image_path), response['name'].capitalize() + '!'

        
            

app = QGuiApplication()

#Coloca a bridge a engine
engine = QQmlApplicationEngine()
engine.load('tela.qml')   

ponte = Ponte()
context = engine.rootContext()
# a gente faz esse conexão e define que tudo na outra chamada referente a ponte diz respeito ao nosso objeto Ponte que armazena a função
context.setContextProperty('ponte',ponte)

app.exec()





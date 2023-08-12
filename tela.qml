import QtQuick
import QtQuick.Controls
//chamando modulo de tema
import QtQuick.Controls.Material

ApplicationWindow {
    visible: true
    width: 500
    height: 400
    font.pixelSize: 24
    Material.theme: 'Dark'
    // row organiza elementos em linha horizontal 
    Row{
        id: row
        spacing: 20
        anchors {
            horizontalCenter: parent.horizontalCenter
            //para criar espaçamento 
            top: parent.top
            // tem que definir o topo pelo parent.top
            topMargin: 20
        }
        


        // Caixa de texto
        TextField{
            //texto de espaço reservado
            id: pokemon_id
            placeholderText: 'Pokemon id'
            width: 200
        }

        Button{
            text: "Get!"
            width: 200
            // vai ser tipo javascript
            //coloca evento onclicked
            onClicked: {
                var pegaPokemon1 = ponte.pegar_pokemon(pokemon_id.text)
                pokemon_id.text = ''
                //Para carregar a img toda vez
                img.source = ''
                label.text = pegaPokemon1[1]
                //Para carregar a imagem com base no id
                img.source = pegaPokemon1[0]
            }
        }
    }
    //add texto fora da row
    Label{
        id: label
        text: "Pokemon"
        anchors {
            horizontalCenter: parent.horizontalCenter
            //nesse caso a referencia para o espaçamento é o row 
            top: row.top
            // tem que definir o topo pelo parent.top
            topMargin: 60
        }
    }
    Image{
        id: img
        width: 300
        height: 300
        //para conseguir carregar toda vez um novo pokemon
        cache: false
        anchors {
            horizontalCenter: parent.horizontalCenter
            //nesse caso a referencia para o espaçamento é o row 
            top: row.top
            // tem que definir o topo pelo parent.top
            topMargin: 80
        }
    }

}
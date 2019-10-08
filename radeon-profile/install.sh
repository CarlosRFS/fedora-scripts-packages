#!/usr/bin/env bash

#cores
azul="033[34;1m"
verde="\033[36;1m"
fim="\033[m"

#variaveis pacotes radeon-profile radeon-profile-daemon
url=https://github.com/marazmista/$pacote

#dependencias
#libXrandr libXrandr-devel qt5-qtcharts qt5-qtcharts-devel
#git
#MENU
echo -e "$verde AVISO:::::Se voce esta utilizando o Fedora tenha certeza de ter instalado os seguintes pacotes antes de continuar\n
==> libXrandr\n
==>libXrandr-devel\n
==>qt5-qtcharts\n
==>qt5-qtcharts-devel\n
==>git\n
:::::::::::::::::::::::::::::::TESTADO APENAS NO FEDORA 31 KDE::::::::::::::::::::::::::::::::::$fim"
while [[ "$var" != "f" ]]; do
	echo "DIGITE "f" PARA CONTINUAR OU "q" PARA SAIR"
	read var
	var=${var,,}
	case var in
		"f")
			break ;;
		"q")
			exit ;;
		  *)
			continue ;;
	esac

done
#verificando dependencias
for i in "git" "qmake-qt5" ; do
	type $i &>/dev/null  && echo -e "$i encontrado..." #|| $( echo -e "$1 não encontrado" && exit )
done       
echo -e "Em qual diretorio deseja baixar o "
#função que realiza o download, compilação
preparando(){
cd $diretorio
echo -e "Baixando o Codigo Fonte do $pacote..."
git clone $url/$pacote

cd $pacote/$pacote/
echo -e "Gerando o Makefile com o qmake..."
qmake-qt5

echo -e "Compilando o pacote..."
make

}

#Função que coloca tudo no lugar
install(){
cd target
cp $pacote /usr/bin/
if [[ "$pacote" = "radeon-profile" ]]; then
	cd ../
	cp extra/$pacote.desktop /usr/share/applications/
	cp extra/$pacote.png /usr/share/pixmaps/
else
	cd ../
	cp extra/$pacote.service /etc/systemd/system/
	systemctl enable $pacote.service && systemctl start $pacote.service
fi
}

for pacote in "radeon-profile" "radeon-profile-daemon"; do
	preparando
	install
done

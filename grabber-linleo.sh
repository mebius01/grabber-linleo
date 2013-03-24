#!/bin/bash

#==========I===========#

PWD=`pwd`

cat Input-Filetxt | sed 's/":"/ - /g' | sed 's/{"context_id":/\n/g' | sed 's/,"/ /g' | sed 's/word_id":/ /g' | awk '{print ($2, $5, $9)}' | sed 's/"//g' | sed 's/ / - /g' > Out-Filetxt.txt
url="http://sound.lingualeo.ru/ukenglishfemale/"
FileId=`awk '{print ($1)}' Out-Filetxt.txt` 

#==========II===========#
# Первое поле Out-Filetxt.txt в массив I, компонуем с урлом и тащим
for I in $FileId
do
	wget $url$I 
done

#==========III===========#
# тот же for добавляем временное hush, чтобы куда-то направить stdout

funone (){
	i=`ls $1`
	d="$PWD/t"
	for j in $i
	do
		cat $j $d > "$j`echo .hush`"
	done
	}

#==========IV===========# Этот кусок написал Frank http://frank-fqc.livejournal.com/

funtwo (){
	i=`ls $1`
# берём по одному имени из массива i и помещаем в переменную j
	for j in $i
	do
# находим в файле строку, содержащую имя файла
	str=`grep $j Out-Filetxt.txt`
# и вычленяем, например, среднюю (вторую) часть между двумя минусами
	name=`echo $str | awk '{print($3, $4, $5)}'`
# после чего переименовываем файл в новое имя, убирая обрамляющие пробелы и добавляя расширение .mp3
	mv $j".hush" "`echo $name`.mp3"
	done
	}

funone '???'
funone '????'
funone '?????'
funone '??????'
funone '???????'

funtwo '???'
funtwo '????'
funtwo '?????'
funtwo '??????'
funtwo '???????'

#==========V===========#
# копируем, перемещаем, удалить отработанный мусор

echo "Имя конечной директории: "
read DIR
awk '{print ($3, $4, $5)}' Out-Filetxt.txt | sort > File-out.txt
cat File-out.txt > Out-Filetxt.txt
rm File-out.txt
mkdir "$DIR"
cp Out-Filetxt.txt "$PWD/$DIR"
cp *.mp3 "$PWD/$DIR"
(cd "$PWD"/"$DIR" && mv Out-Filetxt.txt "$DIR".txt  )
rm *.mp3 *.txt ????? ????

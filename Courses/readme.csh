#!/usr/bin/env tcsh

#
# qss-swirl is from Kosuke's github https://github.com/kosukeimai/qss-swirl, with extra files removed
#

git clone https://github.com/kosukeimai/qss-swirl



cp -r qss-swirl QSS

# tcsh
foreach f (`grep qss-swirl QSS/*/*.* | awk -F: '{print $1}'  | sort -u`)
    cat $f | sed -e "s/qss\-swirl/QSS/g" > foo
    echo $f
    diff $f foo
    mv -f foo $f
end

rm -f foo





rm -rf qss-swirl-socraticswirl
mkdir qss-swirl-socraticswirl
cp -r qss-swirl/[A-Z]*[0-9] qss-swirl-socraticswirl/.	

cd qss-swirl-socraticswirl

# tcsh
foreach f (`ls | sed -e 's/[1-5]//g' | sort -u`)
   mkdir $f
   mv $f? $f
end

rm -f cmd
foreach f ([A-Z]*) 
    foreach g (`grep qss-swirl $f/{$f}?/*.* | awk -F: '{print $1}' | sort -u`) 
        echo 'cat '$g' | sed -e "s/qss-swirl/'$f'/g" > foo' >> cmd
        echo 'echo '$g >> cmd
        echo 'diff '$g' foo | wc' >> cmd
        echo 'mv -f foo '$g >> cmd
        echo 'echo ""' >> cmd
    end
end

csh -x cmd
rm -f cmd 

foreach f ([A-Z]*)
    cd $f
    foreach g (`ls */*.*`)
        echo $g
        diff $g ../../qss-swirl/$g
    end
    cd ..
end


foreach f ( */*/* )
  echo $f
  diff $f /Users/hubertj/Desktop/NewProject/SocraticSwirl/socraticswirlInstructor-2016pol345/courses/qss-swirl-socraticswirl/$f | wc | grep -v "0       0       0" 
  echo ""
end

foreach f ( */*/*/* )
  echo $f
  diff $f /Users/hubertj/Desktop/NewProject/SocraticSwirl/socraticswirlInstructor-2016pol345/courses/qss-swirl-socraticswirl/$f | wc | grep -v "0       0       0"
  echo ""
end


cd ..
\rm -rf QSS
\rm -rf qss-swirl









# folder p should be the same as the RecordFolder in the R code
export p=/Users/hubertj/Desktop/GithubClone/socraticswirlInstructor-RStudioServer/Records/data/Records/*

# folder d should be the same as the MergedFolder in the R code
export d=/Users/hubertj/Desktop/GithubClone/socraticswirlInstructor-RStudioServer/Records

rm -f $d/studentResponse.tsv
cp $d/studentResponseHeader.tsv $d/studentResponse.tsv

for j in $p; do
  # Note: this is slow, and failed to catch the line where ErrorMassage added extra \n
  # for i in $j/*/*/StudentResponse-*.tsv; do 
  #   tail -1 $i | awk -F"\t" '{if (NF == 10) print}' >> $d/studentResponse.tsv 
  # done
  files=($j/*/*/StudentResponse-*.tsv)
  if [ -e "${files[0]}" ];
  then
    cat $j/*/*/StudentResponse-*.tsv | grep "Course\tLesson\tExercise\tStudent\tInstructor" -v | awk -F"\t" '{if (NF == 10) print}' >> $d/studentResponse.tsv  
  fi
done


rm -f $d/studentSession.tsv
cp $d/studentSessionHeader.tsv $d/studentSession.tsv

for j in $p; do
  # This is slow
  # for i in $j/*/*/StudentSession-*.tsv; do
  #  tail -1 $i | awk -F"\t" '{if (NF == 5) print}' >> $d/studentSession.tsv
  # done
  files=($j/*/*/StudentSession-*.tsv)                                                                                                                                                                                                                                  
  if [ -e "${files[0]}" ];
  then
    cat $j/*/*/StudentSession-*.tsv | grep "Course\tLesson\tStudent\tInstructor\tDate" -v | awk -F"\t" '{if (NF == 5) print}' >> $d/studentSession.tsv
  fi
done


rm -f $d/studentQuestion.tsv
cp $d/studentQuestionHeader.tsv $d/studentQuestion.tsv

for j in $p; do
  # for i in $j/*/*/StudentQuestion-*.tsv; do                                                                                                                                                                                                                           
  #   tail -1 $i | awk -F"\t" '{if (NF == 7) print}' >> $d/studentQuestion.tsv                                                                                                                                                                                          
  # done                                                                                                                                                                                                                                                                
  files=($j/*/*/StudentQuestion-*.tsv)
  if [ -e "${files[0]}" ];
  then
    cat $j/*/*/StudentQuestion-*.tsv | grep "Course\tLesson\tStudent\tInstructor\tDate" -v | awk -F"\t" '{if (NF == 7) print}' >> $d/studentQuestion.tsv
  fi
done


# folder p should be the same as the RecordFolder in the R code
export p=/Users/hubertj/Desktop/GithubClone/socraticswirlInstructor-RStudioServer/Records/data/Records/*/*/* 

# folder d should be the same as the MergedFolder in the R code
export d=/Users/hubertj/Desktop/GithubClone/socraticswirlInstructor-RStudioServer/Records

rm -f $d/studentResponse.tsv
cp $d/studentResponseHeader.tsv $d/studentResponse.tsv

for i in $(ls $p/StudentResponse-*.tsv); do 
    tail -1 $i | awk -F"\t" '{if (NF == 10) print}' >> $d/studentResponse.tsv 
done



rm -f $d/studentSession.tsv
cp $d/studentSessionHeader.tsv $d/studentSession.tsv

for i in $(ls $p/StudentSession-*.tsv); do
    tail -1 $i | awk -F"\t" '{if (NF == 5) print}' >> $d/studentSession.tsv
done


rm -f $d/studentQuestion.tsv
cp $d/studentQuestionHeader.tsv $d/studentQuestion.tsv

for i in $(ls $p/StudentQuestion-*.tsv); do
    tail -1 $i | awk -F"\t" '{if (NF == 7) print}' >> $d/studentQuestion.tsv
done



export p=../Records/*/*/* 

rm -f studentResponse.tsv
cp studentResponseHeader.tsv studentResponse.tsv

for i in $(ls $p/StudentResponse-*.tsv); do 
    tail -1 $i | awk -F"\t" '{if (NF == 10) print}' >> studentResponse.tsv 
done



rm -f studentSession.tsv
cp studentSessionHeader.tsv studentSession.tsv

for i in $(ls $p/StudentSession-*.tsv); do
    tail -1 $i | awk -F"\t" '{if (NF == 5) print}' >> studentSession.tsv
done


rm -f studentQuestion.tsv
cp studentQuestionHeader.tsv studentQuestion.tsv

for i in $(ls $p/StudentQuestion-*.tsv); do
    tail -1 $i | awk -F"\t" '{if (NF == 7) print}' >> studentQuestion.tsv
done


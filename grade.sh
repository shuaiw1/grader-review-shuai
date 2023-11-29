CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

EXPECTED_FILE="ListExamples.java"
GRADING_AREA="./grading-area"
TEST_FILE="TestListExamples.java"
echo student-submission/$EXPECTED_FILE
echo "student-submission/$EXPECTED_FILE"

if [ ! -f "student-submission/$EXPECTED_FILE" ]; then
    echo "Error: Expected file $EXPECTED_FILE not found in the submission."
    exit 1
fi    

cp student-submission/$EXPECTED_FILE grading-area
cp $TEST_FILE grading-area
cp -r lib grading-area

cd $GRADING_AREA

javac -cp "$CPATH" *.java
#javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
COMPILE_STATUS=$?

if [ $COMPILE_STATUS -ne 0 ]; then
    echo "Compilation failed. Please check your code for errors."
    exit $COMPILE_STATUS
else
    echo "Compilation successful. "
fi

java -cp "$CPATH" org.junit.runner.JUnitCore TestListExamples
#$ java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore ArrayTests
TEST_STATUS=$?

if [ $TEST_STATUS -eq 0 ]; then
    echo "All tests passed!"
else
    echo "Some tests failed."
fi


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

string StudentID;
Console.WriteLine("Enter student ID: ");
StudentID = Console.ReadLine() + "\0";


//a check variable so we can print an error message if student is not found
bool ck = false;
string StudentName = "\0";


using (var reader = new System.IO.StreamReader(@"D:\3rd Semester\Database Management System Lab\LAB 01\studentInfo.txt"))
{
    while (!reader.EndOfStream)
    {
        var line = reader.ReadLine();
        var values = line.Split(';');
        values = line.Split(';');
        values = line.Split(';');
        values = line.Split(';');
        values = line.Split(';');

        if (Convert.ToInt32(StudentID) ==  Convert.ToInt32(values[0]))
        {
            // if student ID found in file
            //ck value true = student found
            //collect the student name from the file
            ck = true;
            StudentName = values[1];
            break; //stop the search since student is found
        }
    }
}

//terminate program if student was not found in studentInfo.txt
if (!ck)
{
    Console.WriteLine("Student not Found!\n");
    return 0;
}

//store all the acquired GPA over all the semesters 
//store the number of GPAs found (for calculating average GPA)
double GPASum = 0.0;
int GPACount = 0;

using (var reader1 = new System.IO.StreamReader(@"D:\3rd Semester\Database Management System Lab\LAB 01\grades.txt"))
{
    while (!reader1.EndOfStream)
    {
        var line1 = reader1.ReadLine();
        var values1 = line1.Split(';');
        values1 = line1.Split(';');
        values1 = line1.Split(';');

        //if student ID matches in the grades.txt file
        //iterate to find all the GPA and the number of GPAs for that student

        if ((Convert.ToInt32(StudentID) ==  Convert.ToInt32(values1[0])))
        {
            GPACount++;
            GPASum+= Convert.ToDouble(values1[1]);
        }
    }
}

Console.WriteLine("Student name: " + StudentName + "\n" + "CGPA: " + Convert.ToString(GPASum/GPACount) + "\n");


return 0;
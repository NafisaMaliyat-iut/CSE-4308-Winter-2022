string input;
var StudentID = "";
var GPA = "";
var Semester = "";

//take the input all at one in one string
//then it is divided to different strings - studentID, GPA and Semester
Console.WriteLine("Enter Student ID, GPA and Semester (IN ORDER): ");
input = Console.ReadLine() + "\0";



//check the condition for i to avoid array out of bounds (before and after the loop)
// i++ afterwards so as to skip the space that broke the loop
int i = 0;
while (input[i]!= ' ' && input[i]!='\0' && i<input.Length)
{
    StudentID+=input[i];
    i++;
    if (i==input.Length)
        break;
}
i++;

while (input[i]!= ' '  && input[i]!='\0' && i<input.Length)
{
    GPA+=input[i];
    i++;
    if (i==input.Length)
        break;
}
i++;

while (input[i]!= ' '  && input[i]!='\0' && i<input.Length)
{
    Semester+=input[i];
    i++;
    if (i==input.Length)
        break;
}


//checking if the gpa and semester input is valid
//if invalid, no need to search any further
if (Convert.ToDouble(GPA) < 2.50 || Convert.ToDouble(GPA) > 4.00)
{
    Console.WriteLine("Input is invalid!\n");
    return 0;
}

if ( Convert.ToInt32(Semester) < 1 ||  Convert.ToInt32(Semester) > 8)
{
    Console.WriteLine("Input is invalid!\n");
    return 0;
}


//search if student ID exists in studentInfo file
using (var reader = new System.IO.StreamReader(@"D:\3rd Semester\Database Management System Lab\LAB 01\studentInfo.txt"))
{
    bool StudentExists = false;
    while (!reader.EndOfStream)
    {
        var line = reader.ReadLine();
        var values = line.Split(';');
        values = line.Split(';');
        values = line.Split(';');
        values = line.Split(';');
        values = line.Split(';');

        //comparing between student ID entered and the student ID in the file
        //if found, assign a value to the bool value and write to grades.txt file
        if (Convert.ToInt32(values[0]) == Convert.ToInt32(StudentID) )
        {
            StudentExists = true;
            using (System.IO.StreamWriter sw = File.AppendText(@"D:\3rd Semester\Database Management System Lab\LAB 01\grades.txt"))
            {
                sw.Write(StudentID  + ";" + GPA + ";" + Semester );
            }

            Console.WriteLine("Information stored successfully!\n");

            break;
        }

    }

    //error message printed if not found 
    if (!StudentExists)
    {
        Console.WriteLine("Student that you entered doesn't exist.\n");
    }

}



return 0;



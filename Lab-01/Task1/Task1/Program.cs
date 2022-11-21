// See https://aka.ms/new-console-template for more information


double maxGPA = 0.0; //for comparison purpose
string s = "\0"; // to store students id

using (var reader = new System.IO.StreamReader(@"D:\3rd Semester\Database Management System Lab\LAB 01\grades.txt"))
{
    while (!reader.EndOfStream)
    {
        var line = reader.ReadLine();
        var values = line.Split(';');
        values = line.Split(';');

        //if maxGPA is lower than this gpa
        if (maxGPA < Convert.ToDouble(values[1]))
            s = values[0];
        values = line.Split(';');

    }
}

//print that student's id
Console.WriteLine("Student ID with the highest GPA: "+ Convert.ToString(s));


return 0;


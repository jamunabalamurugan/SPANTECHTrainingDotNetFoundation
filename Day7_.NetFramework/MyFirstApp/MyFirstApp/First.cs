using System;
 class First
    {
        static void Main(string[] args)
        {
         Console.WriteLine("Hello World!....fvdfhvhdfvhjsfhhsdfhjgsdhfjgjhjfshjghsd");
        
        Console.WriteLine("Enter first number");
        string str1 = Console.ReadLine();
        Console.WriteLine("Enter second Number");
        string str2 = Console.ReadLine();//accept input from the user through keyboard

        Console.WriteLine("please enter your choice 1.Add 2.Subtract");
        int choice = Convert.ToInt32(Console.ReadLine());

        int a = Convert.ToInt32(str1);
        int b = Convert.ToInt32(str2);
        int c = 5;
        int d = 10;
        float total = c + d,sum=0,result=0;//declare variables of the same type like this
       // Console.WriteLine("Total is "+total);
        Second s = new Second();//creating the object of the class


        if (choice == 1)
        {
            sum = s.Add(a, b);//Calling the method of the class Second
            //Console.WriteLine("The result is " + sum);
        }
        else if(choice==2)
        {
            result = s.Subtract(a, b);
            //Console.WriteLine("The result is" + result);
        }

        Console.WriteLine("Sum is {0} and Difference is {1} and Total is {2}",sum,result,total);
        System.Console.ReadKey();
    }
}

class Second//defining class
{
    public float Add(int num1,int num2)//defining a method ....Add method with parameters
    {
        return num1 + num2;
    }
    public float Subtract(int num1,int num2)
    {
        return (num1 - num2);
    }
}


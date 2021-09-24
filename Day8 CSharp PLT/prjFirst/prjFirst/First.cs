using System;
using prjFirst.slot2;
namespace prjFirst
{
    namespace slot1
    {
        class First
        {
            static void Main()
            {
                Console.WriteLine("Hello!!!Welcome to CSharp");
                string name;
                int age;//System.Int32

                Console.Write("Pls enter your name:");
                name = Console.ReadLine();
                Console.WriteLine("Enter your age");
                //age = Convert.ToInt32(Console.ReadLine());//Explicit Conversion
                
                age = int.Parse(Console.ReadLine());//Explicit Conversion
                float salary = 300000.78f;//System.Single
                int tax = (int)0.5f;//type casting
                //float Num1 = float.Parse("0.5f");//implicit convertion....convert you convert smaller daya type to bigger data type
                float Num1;
                bool status= float.TryParse("0.5", out Num1);
                if (status==true)//if(status).....(!status)....or.....if(status==false)
                {
                    Console.WriteLine("Tax is {0}", tax);
                }
                else
                    Console.WriteLine("Sorry....Cannot convert");

                Console.WriteLine("Welcome!!! "+name+" Age is "+age);
                Console.WriteLine("\nWelcome !!!{0} \tYour age is {1}",name,age);
                Second second = new Second();
                second.Welcome();
                Console.ReadKey();


            }
        }
    }
    namespace slot2
    {
        class Second
        {
            public void Welcome()
            {
                Console.WriteLine("Hello!!!Welcome to CSharp from Second ");
            }
        }
    }
}


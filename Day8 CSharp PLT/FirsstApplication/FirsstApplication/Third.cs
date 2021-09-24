using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FirsstApplication
{
    class Third
    {
        int sno;
        public void Add()
        {
            Console.WriteLine("Add method called");
        }

        public static void Create()
        {
            Console.WriteLine("Create method called");
        }
        public static void Main()
        {
            Third third = new Third();
            third.Add();
            Third obj1 = new Third();
            Third obj2 = new Third();

            obj1.sno = 1;
            obj2.sno = 2;
            Create();
            Console.ReadKey();
        }
    }
}

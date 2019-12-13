using System;

namespace cs
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter your first input:");
            var inputValue1 = Console.ReadLine();
            Console.WriteLine("Enter your second input:");
            var inputValue2 = Console.ReadLine();
            try
            {
                var convertedInput1 = Convert.ToInt32(inputValue1);
                var convertedInput2 = Convert.ToInt32(inputValue2);
            }
            catch (System.Exception)
            {
                Console.WriteLine("Wrong Data Type, Expected Integer");
            }
            finally {
                Console.WriteLine("Finally Exited");
            }

        }
    }
}

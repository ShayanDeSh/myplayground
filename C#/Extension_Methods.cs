using System;

namespace _02
{
    class Program
    {
        static void Main(string[] args)
        {
            // var input = Console.ReadLine();
            // Console.WriteLine(input.seperate_with_3_digit());
            // var now_time_ger = DateTime.Now;
            // Console.WriteLine(DateTime.Now.ger_to_solar());
            var name_input = "shayan shafaghi";
            Console.WriteLine(name_input.name_to_persian());
        }

    }

    public static class Rial
    {
        public static string seperate_with_3_digit(this string input)
        {
            int input_int = 0;
            try
            {
                input_int = Convert.ToInt32(input);
            }
            catch (System.Exception)
            {
                Console.WriteLine("Wrong input");
            }
            return String.Format("{0:n0}", input_int);
        }

    }

    public static class Calendar
    {
        public static string ger_to_solar(this DateTime gergorian)
        {
            DateTime ger = gergorian;
            System.Globalization.PersianCalendar shamsi = new System.Globalization.PersianCalendar();

            return string.Format("{0}/{1}/{2}",
          shamsi.GetYear(ger),
           shamsi.GetMonth(ger),
            shamsi.GetDayOfMonth(ger));

        }
    }

    public static class name
    {
        public static string name_to_persian(this string input_name)
        {
            if (input_name.Equals("shayan shafaghi"))
            {
                return "شایان شفقی";
            }
            return "غلط";
        }
    }


}

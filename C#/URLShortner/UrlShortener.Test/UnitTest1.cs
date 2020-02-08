using System;
using Xunit;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using RA;

namespace UrlShortener.Test
{
    public class UnitTest1
    {
        [Fact]
        public void TestCreate()
        {
		new RestAssured()
		.Given()
		.Name("Create")
		.Header("Content-Type", "application/x-www-form-urlencoded")
		.Body("originalUrl=https://www.p30download.com")
		.Timeout(5000)
		.When()
		.Post("http://localhost:5000/ShortUrl/Create")
		.Then()
		.TestBody("test id",x => x.id != null)
		.Assert("false Id")
		.TestStatus("test status",x => x == 200)
		.Assert("false status")
		.Debug();
	}

	
        [Fact]
        public void TestRedirect()
        {
	        var list = new List<String>();
	        list.Add("utf-8");
		new RestAssured()
			.Given()
			.Name("JsonIP Test Suite")
			.Body("utf-8")
			.When()
		 	.Get("http://www.p30download.com")
			.Then()
			.TestBody("test a", x => x.about != null)
			.Assert("test a");

	}


    }
}

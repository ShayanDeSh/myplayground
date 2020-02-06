using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Routing;
using UrlShortener.Utils;
using UrlShortener.Models;
using UrlShortener.Services;
using System.Text.RegularExpressions;

namespace UrlShortener.Controllers
{
	public class ShortUrlController : Controller 
	{
		private readonly IShortenUrl _service;

		public ShortUrlController(IShortenUrl service)
		{
			_service = service;	
		}

		[HttpPost]
		public IActionResult Create(string originalUrl) 
		{
			Console.WriteLine(originalUrl);
			Regex rgx = new Regex("(http[s]?:\\/\\/)[^\\s([\"<,>]*\\.[^\\s[\\\",><]*");
			if (rgx.IsMatch(originalUrl))
			{
				var shortUrl = new ShortUrl
				{
					OriginalUrl = originalUrl
				};
	
				_service.save(shortUrl);
				Console.WriteLine("GotIt");
				return Created("/ShortUrl/Create", new { id = ReBaser.Encode(shortUrl.Id) }); 
			}
			return Conflict();
		}
		


		[HttpPost]
		public IActionResult Show(int? id)
		{
			if (!id.HasValue)
			{
				return NotFound();
			}

			var shorturl = _service.GetById(id.Value);
			if (shorturl == null)
			{
				return NotFound();
			}

			var shortenedUrl = ReBaser.Encode(shorturl.Id);
			return Accepted(new { shortenUrl = shortenedUrl });
		}
		
		[HttpGet("/ShortUrl/RedirectTo/{path:required}", Name = "ShortUrls_RedirectTo")]
		public IActionResult RedirectTo(string path)
		{
			if (path == null)
			{
				return NotFound();
			}

			var shortUrl = _service.GetByPath(path);
			if (shortUrl == null)
			{
				return NotFound();
			}
			Console.WriteLine(shortUrl.OriginalUrl);
			return Redirect( shortUrl.OriginalUrl); 
		}

		[HttpGet]
		public ActionResult<string> foo() 
		{
			Console.WriteLine("GET");
			return "hello";
		}

	}
}

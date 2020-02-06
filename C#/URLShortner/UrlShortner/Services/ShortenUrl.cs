using UrlShortener.Data;
using UrlShortener.Models;
using UrlShortener.Utils;

namespace UrlShortener.Services
{

	public class ShortenUrl : IShortenUrl
	{
		private ShortUrlContext _context;		
		
		public ShortenUrl(ShortUrlContext context) 
		{
			_context = context;
		}

		public ShortUrl GetById(int id) 
		{
			return _context.ShortUrls.Find(id);
		}
		
		public ShortUrl GetByPath(string path) 
		{
			return _context.ShortUrls.Find(ReBaser.Decode(path));
		}

		
		public ShortUrl GetByOriginalUrl(string originalUrl) 
		{
			foreach (var shortUrl in _context.ShortUrls)
			{
				if (shortUrl.OriginalUrl == originalUrl) 
				{
					return shortUrl;
				}
			}
			return null;
		}

		public int save(ShortUrl shortUrl)
		{
			_context.ShortUrls.Add(shortUrl);
			_context.SaveChanges();
			return shortUrl.Id;
		}
	
	}

}

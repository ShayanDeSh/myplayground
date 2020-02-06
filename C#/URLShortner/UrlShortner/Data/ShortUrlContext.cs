using Microsoft.EntityFrameworkCore;
using UrlShortener.Models;

namespace UrlShortener.Data
{
	public class ShortUrlContext : DbContext
	{	
		public DbSet<ShortUrl> ShortUrls { get; set; }

		public ShortUrlContext(DbContextOptions options) : base(options)
		{
			
		}


		protected override void OnModelCreating(ModelBuilder builder)
		{
			base.OnModelCreating(builder);

			builder
				.Entity<ShortUrl>().
				ToTable("shorturl");
			builder.
				Entity<ShortUrl>().
				HasKey(p => p.Id);
			builder.
				Entity<ShortUrl>().
				Property(p => p.OriginalUrl).
				IsRequired();
		}
	}
}

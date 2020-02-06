using System.ComponentModel.DataAnnotations;

namespace UrlShortener.Models
{
    public class ShortUrl
    {
        public int Id { get; set; }
        
        public string OriginalUrl { get; set; }
    }
}

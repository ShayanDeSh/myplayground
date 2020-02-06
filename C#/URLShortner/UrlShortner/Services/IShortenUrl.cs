using UrlShortener.Models;

namespace UrlShortener.Services
{
  public interface IShortenUrl
  {
    public ShortUrl GetById(int id);

    public ShortUrl GetByPath(string path);

    public ShortUrl GetByOriginalUrl(string originalUrl);

    public int save(ShortUrl shortUrl);
  }
}

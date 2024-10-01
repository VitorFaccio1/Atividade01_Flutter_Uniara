using Microsoft.EntityFrameworkCore;
using WebApplication1.Models;

namespace WebApplication1.Data;

public class WebApplication1Context : DbContext
{
    public WebApplication1Context(DbContextOptions<WebApplication1Context> options)
        : base(options)
    {
    }

    public DbSet<User> Users { get; set; } = default!;

public DbSet<WebApplication1.Models.Store> Stores { get; set; } = default!;
}
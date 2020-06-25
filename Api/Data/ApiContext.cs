using Api.Models;
using Microsoft.EntityFrameworkCore;

namespace Api.Data
{
    public class ApiContext : DbContext
    {
        public ApiContext(DbContextOptions options) : base(options) { }
        public DbSet<Address> Addresses { get; set; }
        public DbSet<Patient> Patients { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Address>(entity =>
            {
                entity.ToTable("address");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.AddressComplement)
                    .HasColumnType("varchar(250)");

                entity.Property(e => e.City)
                    .HasColumnType("varchar(100)")
                    .IsRequired();

                entity.Property(e => e.Number)
                    .HasColumnType("varchar(10)")
                    .IsRequired();

                entity.Property(e => e.Neighborhood)
                    .HasColumnType("varchar(100)")
                    .IsRequired();

                entity.Property(e => e.PublicPlace)
                    .HasColumnType("varchar(250)")
                    .IsRequired();

                entity.Property(e => e.State)
                    .HasColumnType("varchar(75)")
                    .IsRequired();

                entity.Property(e => e.ZipCode)
                    .HasColumnType("varchar(8)")
                    .IsRequired();

                entity.HasOne(e => e.Patient)
                    .WithOne(e => e.Address)
                    .HasForeignKey<Address>(e => e.PatientId);
            });

            modelBuilder.Entity<Patient>(entity =>
            {
                entity.ToTable("patient");

                entity.HasKey(e => e.Id);

                entity.Property(e => e.Active)
                    .HasColumnType("bit")
                    .IsRequired();

                entity.Property(e => e.BloodType)
                    .HasColumnType("varchar(10)")
                    .IsRequired();

                entity.Property(e => e.Name)
                    .HasColumnType("varchar(200)")
                    .IsRequired();

                entity.Property(e => e.YearsOld)
                    .HasColumnType("tinyint")
                    .IsRequired();
            });
        }
    }
}

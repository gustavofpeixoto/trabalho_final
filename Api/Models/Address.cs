using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Api.Models
{
    public class Address : Entity
    {
        public string AddressComplement { get; set; }
        public string City { get; set; }
        public string Number { get; set; }
        public string Neighborhood { get; set; }
        public string PublicPlace { get; set; }
        public string State { get; set; }
        public string ZipCode { get; set; }

        //EF Relation

        public Guid PatientId { get; set; }
        public Patient Patient { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;
using System.Threading.Tasks;

namespace Api.Models
{
    public class Patient : Entity
    {
        public bool Active { get; set; }
        public string BloodType { get; set; }
        public string Name { get; set; }
        public int YearsOld { get; set; }

        //EF Relation

        public Address Address { get; set; }
    }
}

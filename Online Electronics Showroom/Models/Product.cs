using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Online_Electronics_Showroom.Models
{
    public class Product
    {
        public string ProductID { get; set; }
        public string Name { get; set; }
        public string CategoryID { get; set; }
        public string Description { get; set; }
        public decimal UnitPrice { get; set; }
        public string Quantity { get; set; }
    }
}
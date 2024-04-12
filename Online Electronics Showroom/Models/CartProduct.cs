using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Online_Electronics_Showroom.Models
{
    public class CartProduct
    {
        public CartProduct() { }

        public CartProduct(Product Product, int quantity)
        {
            this.Product = Product;
            this.Quantity = quantity;
        }

        public Product Product { get; set; }
        public int Quantity { get; set; }

        public void AddQuantity(int quantity)
        {
            this.Quantity += quantity;
        }

        public string Display()
        {
            string displayString = string.Format("{0} ({1} at {2})",
                Product.Name,
                Quantity.ToString(),
                Product.UnitPrice.ToString("c")
            );
            return displayString;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Online_Electronics_Showroom.Models
{
    public class CartProductList
    {
        private List<CartProduct> CartProducts;

        public CartProductList()
        {
            CartProducts = new List<CartProduct>();
        }

        public int Count
        {
            get { return CartProducts.Count; }
        }

        public CartProduct this[int index]
        {
            get { return CartProducts[index]; }
            set { CartProducts[index] = value; }
        }

        public CartProduct this[string id]
        {
            get
            {
                foreach (CartProduct b in CartProducts)
                    if (b.Product.ProductID == id) return b;
                return null;
            }
        }

        public static CartProductList GetCart()
        {
            CartProductList cart = (CartProductList)HttpContext.Current.Session["Cart"];
            if (cart == null)
                HttpContext.Current.Session["Cart"] = new CartProductList();
            return (CartProductList)HttpContext.Current.Session["Cart"];
        }

        public void AddItem(Product Product, int quantity)
        {
            CartProduct c = new CartProduct(Product, quantity);
            CartProducts.Add(c);
        }

        public void RemoveAt(int index)
        {
            CartProducts.RemoveAt(index);
        }

        public void Clear()
        {
            CartProducts.Clear();
        }
    }
}
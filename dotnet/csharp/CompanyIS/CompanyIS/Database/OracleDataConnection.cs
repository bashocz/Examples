using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.OracleClient;
using System.Security.Cryptography;

namespace Basho
{
    public class OracleDataConnection : IDataConnection
    {
        #region private fields

        private readonly string connectionString = "Data Source=localhost:1521/xe;User Id=system;Password=sys;";
        //private readonly string connectionString = "Data Source=argexpr.vsb.cz:1521/oracle;User Id=bar118;Password=bar118;";

        #endregion

        #region private methods

        private string CheckForInjection(string str)
        {
            int idx = 0;
            while (idx < str.Length)
            {
                if (!char.IsLetterOrDigit(str[idx]) &&
                    !char.IsSymbol(str[idx]) &&
                    !char.IsWhiteSpace(str[idx]))
                    str = str.Remove(idx, 1);
                else
                    idx++;
            }
            return str;
        }

        private OracleParameter GetNVarChar(string name, string value)
        {
            OracleParameter par = new OracleParameter(name, OracleType.NVarChar);
            par.Value = value;
            return par;
        }

        private OracleParameter GetNumber(string name, Nullable<int> value)
        {
            OracleParameter par = new OracleParameter(name, OracleType.Number);
            if (value != null)
                par.Value = value;
            return par;
        }

        private OracleParameter GetDouble(string name, Nullable<double> value)
        {
            OracleParameter par = new OracleParameter(name, OracleType.Number);
            if (value != null)
                par.Value = value;
            return par;
        }

        private string GetPasswordHash(string password)
        {
            MD5CryptoServiceProvider crypto = new MD5CryptoServiceProvider();
            byte[] bytePassword = Encoding.UTF8.GetBytes(password);
            byte[] byteHash = crypto.ComputeHash(bytePassword);
            StringBuilder hash = new StringBuilder();
            foreach (byte item in byteHash)
            {
                hash.Append(item.ToString("x2").ToLower());
            }
            return hash.ToString();
        }

        private User GetUser(string name, string role, Nullable<int> customerId)
        {
            if (string.Compare(role, "Zakaznik", true) == 0)
                return new User
                {
                    Name = name,
                    Role = Role.Zakaznik,
                    CustomerId = (int)customerId
                };
            else if (string.Compare(role, "Obchodnik", true) == 0)
                return new User
                {
                    Name = name,
                    Role = Role.Obchodnik
                };
            return new User
            {
                Name = name,
                Role = Role.Vyroba
            };
        }

        private Customer GetCustomer(int id, string name, string street, int number, string city, int psc, string phone, int active)
        {
            return new Customer
            {
                Id = id,
                Name = name,
                Street = street,
                Number = number,
                City = city,
                Psc = psc,
                Phone = phone,
                Active = active
            };
        }

        private Product GetProduct(int id, string name, double price, double timeConsuming, int active)
        {
            return new Product
            {
                Id = id,
                Name = name,
                Price = price,
                TimeConsuming = timeConsuming,
                Active = active
            };
        }

        private ProductionLine GetProductionLine(int id, string name, int capacity, double efficiency, int active)
        {
            return new ProductionLine
            {
                Id = id,
                Name = name,
                Capacity = capacity,
                Efficiency = efficiency,
                Active = active
            };
        }

        private Order GetOrder(int id, int customerId, DateTime dateOrder, Nullable<DateTime> dateShipment, string state)
        {
            return new Order
            {
                Id = id,
                CustomerId = customerId,
                DateOrder = dateOrder,
                DateShipment = dateShipment,
                State = state
            };
        }

        private Plan GetPlan(int id, int productId, Nullable<int> orderId, Nullable<int> productionLineId,
            DateTime dateCreation, Nullable<DateTime> dateStart, Nullable<DateTime> dateEnd, int count, string state)
        {
            return new Plan
            {
                Id = id,
                ProductId = productId,
                OrderId = orderId,
                ProductionLineId = productionLineId,
                DateCreation = dateCreation,
                DateStart = dateStart,
                DateEnd = dateEnd,
                Count = count,
                State = state,
            };
        }

        private int AddUpdateField(OracleCommand cmd, string param, int paramIdx, string newStr, string oldStr)
        {
            if (string.Compare(oldStr, newStr) != 0)
            {
                if (paramIdx > 1)
                    cmd.CommandText += ",";
                cmd.CommandText += param + " = :" + paramIdx.ToString();
                cmd.Parameters.Add(GetNVarChar(":" + paramIdx.ToString(), newStr));
                return paramIdx + 1;
            }
            return paramIdx;
        }

        private int AddUpdateField(OracleCommand cmd, string param, int paramIdx, int newInt, int oldInt)
        {
            if (oldInt != newInt)
            {
                if (paramIdx > 1)
                    cmd.CommandText += ",";
                cmd.CommandText += param + " = :" + paramIdx.ToString();
                cmd.Parameters.Add(GetNumber(":" + paramIdx.ToString(), newInt));
                return paramIdx + 1;
            }
            return paramIdx;
        }

        private int AddUpdateField(OracleCommand cmd, string param, int paramIdx, double newDouble, double oldDouble)
        {
            if (oldDouble != newDouble)
            {
                if (paramIdx > 1)
                    cmd.CommandText += ",";
                cmd.CommandText += param + " = :" + paramIdx.ToString();
                cmd.Parameters.Add(GetDouble(":" + paramIdx.ToString(), newDouble));
                return paramIdx + 1;
            }
            return paramIdx;
        }

        #endregion

        #region private queries

        #region customer

        private void InsertCustomer(OracleConnection connection, string name, string street, int number, string city, int psc, string phone)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "insert into tis_zakaznik (jmeno,ulice,cislo,mesto,psc,telefon) values(:1,:2,:3,:4,:5,:6)";
            cmd.Parameters.Add(GetNVarChar(":1", CheckForInjection(name)));
            cmd.Parameters.Add(GetNVarChar(":2", CheckForInjection(street)));
            cmd.Parameters.Add(GetNumber(":3", number));
            cmd.Parameters.Add(GetNVarChar(":4", CheckForInjection(city)));
            cmd.Parameters.Add(GetNumber(":5", psc));
            cmd.Parameters.Add(GetNVarChar(":6", CheckForInjection(phone)));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private void UpdateCustomer(OracleConnection connection, Customer newCustomer, Customer oldCustomer)
        {
            if (newCustomer.Id != oldCustomer.Id) // probably different customers - wrong input
                return;

            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "update tis_zakaznik set ";
            cmd.CommandType = CommandType.Text;

            int paramIdx = 1;
            paramIdx = AddUpdateField(cmd, "jmeno", paramIdx, CheckForInjection(newCustomer.Name), oldCustomer.Name);
            paramIdx = AddUpdateField(cmd, "ulice", paramIdx, CheckForInjection(newCustomer.Street), oldCustomer.Street);
            paramIdx = AddUpdateField(cmd, "cislo", paramIdx, newCustomer.Number, oldCustomer.Number);
            paramIdx = AddUpdateField(cmd, "mesto", paramIdx, CheckForInjection(newCustomer.City), oldCustomer.City);
            paramIdx = AddUpdateField(cmd, "psc", paramIdx, newCustomer.Psc, oldCustomer.Psc);
            paramIdx = AddUpdateField(cmd, "telefon", paramIdx, CheckForInjection(newCustomer.Phone), oldCustomer.Phone);
            paramIdx = AddUpdateField(cmd, "aktivni", paramIdx, newCustomer.Active, oldCustomer.Active);
            if (paramIdx > 1)
            {
                cmd.CommandText += " where zakaznik_id = :" + paramIdx.ToString();
                cmd.Parameters.Add(GetNumber(":" + paramIdx.ToString(), newCustomer.Id));
                cmd.ExecuteNonQuery();
            }
            cmd.Dispose();
        }

        private void DeleteCustomer(OracleConnection connection, Customer customer)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "delete from tis_zakaznik where zakaznik_id = :1";
            cmd.Parameters.Add(GetNumber(":1", customer.Id));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private Customer GetCustomer(OracleConnection connection, int customerId)
        {
            Customer customer = null;
            // select record from table
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select * from tis_zakaznik where zakaznik_id = :1";
            cmd.Parameters.Add(GetNumber(":1", customerId));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                customer = GetCustomer(reader.GetInt32(0), reader.GetString(1), reader.GetString(2),
                    reader.GetInt32(3), reader.GetString(4), reader.GetInt32(5), reader.GetString(6), reader.GetInt32(7));

            reader.Close();
            cmd.Dispose();

            return customer;
        }

        private Customer GetCustomer(OracleConnection connection, string name, string street, int number, string city, int psc, string phone)
        {
            Customer customer = null;
            // select record from table
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select * from tis_zakaznik " +
                                "where jmeno = :1 and ulice = :2 and cislo = :3 and " +
                                "mesto = :4 and psc = :5 and telefon = :6";
            cmd.Parameters.Add(GetNVarChar(":1", CheckForInjection(name)));
            cmd.Parameters.Add(GetNVarChar(":2", CheckForInjection(street)));
            cmd.Parameters.Add(GetNumber(":3", number));
            cmd.Parameters.Add(GetNVarChar(":4", CheckForInjection(city)));
            cmd.Parameters.Add(GetNumber(":5", psc));
            cmd.Parameters.Add(GetNVarChar(":6", CheckForInjection(phone)));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                customer = GetCustomer(reader.GetInt32(0), reader.GetString(1), reader.GetString(2),
                    reader.GetInt32(3), reader.GetString(4), reader.GetInt32(5), reader.GetString(6), reader.GetInt32(7));

            reader.Close();
            cmd.Dispose();

            return customer;
        }

        private List<Customer> GetCustomers(OracleConnection connection, RecordInfo info)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select count(*) from tis_zakaznik";
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                info.Total = reader.GetInt32(0);

            reader.Close();
            cmd.Dispose();

            List<Customer> customers = new List<Customer>();
            // select record from table
            cmd = connection.CreateCommand();
            cmd.CommandText = "select * from " +
                                "(select rownum rn, z.* from tis_zakaznik z)" +
                                " where rn >= :1 and rn < :2";
            cmd.Parameters.Add(GetNumber(":1", info.Start));
            cmd.Parameters.Add(GetNumber(":2", info.Start + info.Count));
            reader = cmd.ExecuteReader();

            while (reader.Read())
                customers.Add(GetCustomer(reader.GetInt32(1), reader.GetString(2), reader.GetString(3),
                    reader.GetInt32(4), reader.GetString(5), reader.GetInt32(6), reader.GetString(7), reader.GetInt32(8)));

            reader.Close();
            cmd.Dispose();

            return customers;
        }

        #endregion

        #region product

        private void InsertProduct(OracleConnection connection, string name, double price, double timeConsuming)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "insert into tis_vyrobek (nazev,cena,narocnost) values(:1,:2,:3)";
            cmd.Parameters.Add(GetNVarChar(":1", CheckForInjection(name)));
            cmd.Parameters.Add(GetDouble(":2", price));
            cmd.Parameters.Add(GetDouble(":3", timeConsuming));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private void UpdateProduct(OracleConnection connection, Product newProduct, Product oldProduct)
        {
            if (newProduct.Id != oldProduct.Id) // probably different products - wrong input
                return;

            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "update tis_vyrobek set ";
            cmd.CommandType = CommandType.Text;

            int paramIdx = 1;
            paramIdx = AddUpdateField(cmd, "nazev", paramIdx, CheckForInjection(newProduct.Name), oldProduct.Name);
            paramIdx = AddUpdateField(cmd, "cena", paramIdx, newProduct.Price, oldProduct.Price);
            paramIdx = AddUpdateField(cmd, "narocnost", paramIdx, newProduct.TimeConsuming, oldProduct.TimeConsuming);
            paramIdx = AddUpdateField(cmd, "aktivni", paramIdx, newProduct.Active, oldProduct.Active);
            if (paramIdx > 1)
            {
                cmd.CommandText += " where vyrobek_id = :" + paramIdx.ToString();
                cmd.Parameters.Add(GetNumber(":" + paramIdx.ToString(), newProduct.Id));
                cmd.ExecuteNonQuery();
            }
            cmd.Dispose();
        }

        private void DeleteProduct(OracleConnection connection, Product product)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "delete from tis_vyrobek where vyrobek_id = :1";
            cmd.Parameters.Add(GetNumber(":1", product.Id));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private Product GetProduct(OracleConnection connection, int productId)
        {
            Product product = null;
            // select record from table
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select * from tis_vyrobek where vyrobek_id = :1";
            cmd.Parameters.Add(GetNumber(":1", productId));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                product = GetProduct(reader.GetInt32(0), reader.GetString(1),
                    reader.GetDouble(2), reader.GetDouble(3), reader.GetInt32(4));

            reader.Close();
            cmd.Dispose();

            return product;
        }

        private Product GetProduct(OracleConnection connection, string name)
        {
            Product product = null;
            // select record from table
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select * from tis_vyrobek where nazev = :1";
            cmd.Parameters.Add(GetNVarChar(":1", CheckForInjection(name)));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                product = GetProduct(reader.GetInt32(0), reader.GetString(1),
                    reader.GetDouble(2), reader.GetDouble(3), reader.GetInt32(4));

            reader.Close();
            cmd.Dispose();

            return product;
        }

        private List<Product> GetProducts(OracleConnection connection, RecordInfo info)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select count(*) from tis_vyrobek";
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                info.Total = reader.GetInt32(0);

            reader.Close();
            cmd.Dispose();

            List<Product> products = new List<Product>();
            // select record from table
            cmd = connection.CreateCommand();
            cmd.CommandText = "select * from " +
                                "(select rownum rn, v.* from tis_vyrobek v)" +
                                " where rn >= :1 and rn < :2";
            cmd.Parameters.Add(GetNumber(":1", info.Start));
            cmd.Parameters.Add(GetNumber(":2", info.Start + info.Count));
            reader = cmd.ExecuteReader();

            while (reader.Read())
                products.Add(GetProduct(reader.GetInt32(1), reader.GetString(2),
                    reader.GetDouble(3), reader.GetDouble(4), reader.GetInt32(5)));

            reader.Close();
            cmd.Dispose();

            return products;
        }

        #endregion

        #region production line

        private void InsertProductionLine(OracleConnection connection, string name, int capacity, double efficiency)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "insert into tis_vyrobni_linka (nazev,kapacita,vykonnost) values(:1,:2,:3)";
            cmd.Parameters.Add(GetNVarChar(":1", CheckForInjection(name)));
            cmd.Parameters.Add(GetNumber(":2", capacity));
            cmd.Parameters.Add(GetDouble(":3", efficiency));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private void UpdateProductionLine(OracleConnection connection, ProductionLine newLine, ProductionLine oldLine)
        {
            if (newLine.Id != oldLine.Id) // probably different production lines - wrong input
                return;

            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "update tis_vyrobni_linka set ";
            cmd.CommandType = CommandType.Text;

            int paramIdx = 1;
            paramIdx = AddUpdateField(cmd, "nazev", paramIdx, CheckForInjection(newLine.Name), oldLine.Name);
            paramIdx = AddUpdateField(cmd, "kapacita", paramIdx, newLine.Capacity, oldLine.Capacity);
            paramIdx = AddUpdateField(cmd, "vykonnost", paramIdx, newLine.Efficiency, oldLine.Efficiency);
            paramIdx = AddUpdateField(cmd, "aktivni", paramIdx, newLine.Active, oldLine.Active);
            if (paramIdx > 1)
            {
                cmd.CommandText += " where vyrobni_linka_id = :" + paramIdx.ToString();
                cmd.Parameters.Add(GetNumber(":" + paramIdx.ToString(), newLine.Id));
                cmd.ExecuteNonQuery();
            }
            cmd.Dispose();
        }

        private void DeleteProductionLine(OracleConnection connection, ProductionLine line)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "delete from tis_vyrobni_linka where vyrobni_linka_id = :1";
            cmd.Parameters.Add(GetNumber(":1", line.Id));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private ProductionLine GetProductionLine(OracleConnection connection, int productionLineId)
        {
            ProductionLine productionLine = null;
            // select record from table
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select * from tis_vyrobni_linka where vyrobni_linka_id = :1";
            cmd.Parameters.Add(GetNumber(":1", productionLineId));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                productionLine = GetProductionLine(reader.GetInt32(0),
                    reader.GetString(1), reader.GetInt32(2), reader.GetDouble(3), reader.GetInt32(4));

            reader.Close();
            cmd.Dispose();

            return productionLine;
        }

        private ProductionLine GetProductionLine(OracleConnection connection, string name)
        {
            ProductionLine productionLine = null;
            // select record from table
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select * from tis_vyrobni_linka where nazev = :1";
            cmd.Parameters.Add(GetNVarChar(":1", CheckForInjection(name)));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                productionLine = GetProductionLine(reader.GetInt32(0),
                    reader.GetString(1), reader.GetInt32(2), reader.GetDouble(3), reader.GetInt32(4));

            reader.Close();
            cmd.Dispose();

            return productionLine;
        }

        private List<ProductionLine> GetProductionLines(OracleConnection connection, RecordInfo info)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select count(*) from tis_vyrobni_linka";
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                info.Total = reader.GetInt32(0);

            reader.Close();
            cmd.Dispose();

            List<ProductionLine> productionLines = new List<ProductionLine>();
            // select record from table
            cmd = connection.CreateCommand();
            cmd.CommandText = "select * from " +
                                "(select rownum rn, l.* from tis_vyrobni_linka l)" +
                                " where rn >= :1 and rn < :2";
            cmd.Parameters.Add(GetNumber(":1", info.Start));
            cmd.Parameters.Add(GetNumber(":2", info.Start + info.Count));
            reader = cmd.ExecuteReader();

            while (reader.Read())
                productionLines.Add(GetProductionLine(reader.GetInt32(1),
                    reader.GetString(2), reader.GetInt32(3), reader.GetDouble(4), reader.GetInt32(5)));

            reader.Close();
            cmd.Dispose();

            return productionLines;
        }

        #endregion

        #region order item

        private void InsertItem(OracleConnection connection, Order order, Product product, int count)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "insert into tis_polozka (zakazka_id,vyrobek_id,pocet) values(:1,:2,:3)";
            cmd.Parameters.Add(GetNumber(":1", order.Id));
            cmd.Parameters.Add(GetNumber(":2", product.Id));
            cmd.Parameters.Add(GetNumber(":3", count));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private void UpdateItem(OracleConnection connection, Item item)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "update tis_polozka set pocet = :1 where zakazka_id = :2 and vyrobek_id = :3";
            cmd.Parameters.Add(GetNumber(":1", item.Count));
            cmd.Parameters.Add(GetNumber(":2", item.OrderId));
            cmd.Parameters.Add(GetNumber(":3", item.ProductId));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private void DeleteItem(OracleConnection connection, Item item)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "delete from tis_polozka where zakazka_id = :1 and vyrobek_id = :2";
            cmd.Parameters.Add(GetNumber(":1", item.Order.Id));
            cmd.Parameters.Add(GetNumber(":2", item.Product.Id));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private List<Item> GetItems(OracleConnection connection, Order order)
        {
            List<Item> items = new List<Item>();

            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select v.*, p.pocet from tis_vyrobek v, tis_polozka p" +
                                " where p.vyrobek_id = v.vyrobek_id and p.zakazka_id = :1";
            cmd.Parameters.Add(GetNumber(":1", order.Id));
            OracleDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                items.Add(new Item
                {
                    OrderId = order.Id,
                    Order = order,
                    ProductId = reader.GetInt32(0),
                    Product = GetProduct(reader.GetInt32(0), reader.GetString(1), reader.GetDouble(2), reader.GetDouble(3), reader.GetInt32(4)),
                    Count = reader.GetInt32(5)
                });
            }

            reader.Close();
            cmd.Dispose();

            return items;
        }

        #endregion

        #region order

        private int NewOrder(OracleConnection connection, Customer customer)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "TIS.nova_zakazka";
            cmd.CommandType = CommandType.StoredProcedure;
            OracleParameter res = cmd.Parameters.Add("result", OracleType.Number);
            res.Direction = ParameterDirection.ReturnValue;
            OracleParameter par = cmd.Parameters.Add("p_zakaznik_id", OracleType.Number);
            par.Value = customer.Id;
            cmd.ExecuteNonQuery();

            int orderId = Convert.ToInt32(res.Value);
            cmd.Dispose();

            return orderId;
        }

        private void AcceptOrder(OracleConnection connection, Order order)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "TIS.potvrzeni_zakazka";
            cmd.CommandType = CommandType.StoredProcedure;
            OracleParameter par = cmd.Parameters.Add("p_zakazka_id", OracleType.Number);
            par.Value = order.Id;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private void CancelOrder(OracleConnection connection, Order order)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "TIS.storno_zakazka";
            cmd.CommandType = CommandType.StoredProcedure;
            OracleParameter par = cmd.Parameters.Add("p_zakazka_id", OracleType.Number);
            par.Value = order.Id;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private void SendOrder(OracleConnection connection, Order order)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "TIS.odesli_zakazku";
            cmd.CommandType = CommandType.StoredProcedure;
            OracleParameter par = cmd.Parameters.Add("p_zakazka_id", OracleType.Number);
            par.Value = order.Id;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private double GetOrderTotalPrice(OracleConnection connection, int orderId)
        {
            double price = 0;
            // select record from table
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select sum(p.pocet * v.cena) from tis_polozka p, tis_vyrobek v" +
                                " where p.vyrobek_id = v.vyrobek_id and p.zakazka_id = :1";
            cmd.Parameters.Add(GetNumber(":1", orderId));
            object result = cmd.ExecuteScalar();
            if (result != null)
            {
                try
                {
                    price = Convert.ToDouble(result);
                }
                catch { }
            }

            cmd.Dispose();

            return price;
        }

        private Order GetOrder(OracleConnection connection, int orderId)
        {
            Order order = null;
            // select record from table
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select z.* from tis_zakazka z where z.zakazka_id = :1";
            cmd.Parameters.Add(GetNumber(":1", orderId));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                Nullable<DateTime> dateShipment = null;
                if (!reader.IsDBNull(3))
                    dateShipment = reader.GetDateTime(3);
                order = GetOrder(reader.GetInt32(0), reader.GetInt32(1), reader.GetDateTime(2),
                    dateShipment, reader.GetString(4));
            }

            reader.Close();
            cmd.Dispose();

            order.TotalPrice = GetOrderTotalPrice(connection, orderId);
            
            return order;
        }

        private List<Order> GetOrders(OracleConnection connection, RecordInfo info)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select count(*) from tis_zakazka z, tis_zakaznik zk" +
                                " where z.zakaznik_id = zk.zakaznik_id order by z.zakaznik_id, z.datum_objednavky";
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                info.Total = reader.GetInt32(0);

            reader.Close();
            cmd.Dispose();

            List<Order> orders = new List<Order>();
            // select record from table
            cmd = connection.CreateCommand();
            cmd.CommandText = "select * from " +
                                "(select rownum rn, z.*, zk.jmeno, zk.ulice, zk.cislo, zk.mesto, zk.psc, zk.telefon, zk.aktivni" +
                                " from tis_zakazka z, tis_zakaznik zk" +
                                " where z.zakaznik_id = zk.zakaznik_id order by z.zakaznik_id, z.datum_objednavky)" +
                                " where rn >= :1 and rn < :2";
            cmd.Parameters.Add(GetNumber(":1", info.Start));
            cmd.Parameters.Add(GetNumber(":2", info.Start + info.Count));
            reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Nullable<DateTime> dateShipment = null;
                if (!reader.IsDBNull(4))
                    dateShipment = reader.GetDateTime(4);
                Order order = GetOrder(reader.GetInt32(1), reader.GetInt32(2), reader.GetDateTime(3),
                    dateShipment, reader.GetString(5));
                order.Customer = GetCustomer(reader.GetInt32(2), reader.GetString(6), reader.GetString(7),
                    reader.GetInt32(8), reader.GetString(9), reader.GetInt32(10), reader.GetString(11), reader.GetInt32(12));
                orders.Add(order);
            }

            reader.Close();
            cmd.Dispose();

            foreach(Order order in orders)
                order.TotalPrice = GetOrderTotalPrice(connection, order.Id);

            return orders;
        }

        private List<Order> GetOrders(OracleConnection connection, Customer customer, RecordInfo info)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select count(*) from tis_zakazka z where z.zakaznik_id = :1 order by z.datum_objednavky";
            cmd.Parameters.Add(GetNumber(":1", customer.Id));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                info.Total = reader.GetInt32(0);

            reader.Close();
            cmd.Dispose();

            List<Order> orders = new List<Order>();
            // select record from table
            cmd = connection.CreateCommand();
            cmd.CommandText = "select * from " +
                                "(select rownum rn, z.* from tis_zakazka z where z.zakaznik_id = :1 order by z.datum_objednavky)" +
                                " where rn >= :2 and rn < :3";
            cmd.Parameters.Add(GetNumber(":1", customer.Id));
            cmd.Parameters.Add(GetNumber(":2", info.Start));
            cmd.Parameters.Add(GetNumber(":3", info.Start + info.Count));
            reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Nullable<DateTime> dateShipment = null;
                if (!reader.IsDBNull(4))
                    dateShipment = reader.GetDateTime(4);
                Order order = GetOrder(reader.GetInt32(1), reader.GetInt32(2), reader.GetDateTime(3),
                    dateShipment, reader.GetString(5));
                order.Customer = customer;
                orders.Add(order);
            }

            reader.Close();
            cmd.Dispose();

            foreach (Order order in orders)
                order.TotalPrice = GetOrderTotalPrice(connection, order.Id);

            return orders;
        }

        #endregion

        #region production

        private Nullable<int> ProductionStart(OracleConnection connection, ProductionLine line)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "TIS.vyroba_start";
            cmd.CommandType = CommandType.StoredProcedure;
            OracleParameter res = cmd.Parameters.Add("result", OracleType.Int32);
            res.Direction = ParameterDirection.ReturnValue;
            OracleParameter par = cmd.Parameters.Add("p_vyrobni_linka_id", OracleType.Number);
            par.Value = line.Id;
            cmd.ExecuteNonQuery();

            Nullable<int> planId = null;
            try
            {
                planId = Convert.ToInt32(res.Value);
            }
            catch { }
            cmd.Dispose();

            return planId;
        }

        private void ProductionEnd(OracleConnection connection, ProductionLine line)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "TIS.vyroba_konec";
            cmd.CommandType = CommandType.StoredProcedure;
            OracleParameter par = cmd.Parameters.Add("p_vyrobni_linka_id", OracleType.Number);
            par.Value = line.Id;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        #endregion

        #region plan

        private Plan GetPlan(OracleConnection connection, int planId)
        {
            Plan plan = null;

            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select * from tis_plan p, tis_vyrobek v" +
                                " where p.vyrobek_id = v.vyrobek_id and p.plan_id = :1";
            cmd.Parameters.Add(GetNumber(":1", planId));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                Nullable<int> orderId = null;
                if (!reader.IsDBNull(2))
                    orderId = reader.GetInt32(2);
                Nullable<int> productionLineId = null;
                if (!reader.IsDBNull(3))
                    productionLineId = reader.GetInt32(3);
                Nullable<DateTime> dateStart = null;
                if (!reader.IsDBNull(5))
                    dateStart = reader.GetDateTime(5);
                Nullable<DateTime> dateEnd = null;
                if (!reader.IsDBNull(6))
                    dateEnd = reader.GetDateTime(6);
                plan = GetPlan(reader.GetInt32(0), reader.GetInt32(1), orderId, productionLineId,
                    reader.GetDateTime(4), dateStart, dateEnd, reader.GetInt32(7), reader.GetString(8));
                plan.Product = GetProduct(reader.GetInt32(9), reader.GetString(10), reader.GetDouble(11), reader.GetDouble(12), reader.GetInt32(13));
            }

            cmd.Dispose();

            if (plan != null)
            {
                // get order - musts be new query
                if (plan.OrderId != null)
                    plan.Order = GetOrder(connection, (int)plan.OrderId);
                // get production line - musts be new query
                if (plan.ProductionLineId != null)
                    plan.ProductionLine = GetProductionLine(connection, (int)plan.ProductionLineId);
            }

            return plan;
        }

        private Plan GetProductionLinePlan(OracleConnection connection, ProductionLine line)
        {
            Plan plan = null;

            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select * from " +
                                "(select * from tis_plan where vyrobni_linka_id = :1 order by datum_vyroba_start desc)" +
                                " where rownum = 1";
            cmd.Parameters.Add(GetNumber(":1", line.Id));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                Nullable<int> orderId = null;
                if (!reader.IsDBNull(2))
                    orderId = reader.GetInt32(2);
                Nullable<DateTime> dateStart = null;
                if (!reader.IsDBNull(5))
                    dateStart = reader.GetDateTime(5);
                Nullable<DateTime> dateEnd = null;
                if (!reader.IsDBNull(6))
                    dateEnd = reader.GetDateTime(6);
                plan = GetPlan(reader.GetInt32(0), reader.GetInt32(1), orderId, line.Id,
                    reader.GetDateTime(4), dateStart, dateEnd, reader.GetInt32(7), reader.GetString(8));
                plan.ProductionLine = line;
            }

            cmd.Dispose();

            if (plan != null)
            {
                // get product - musts be new query
                plan.Product = GetProduct(connection, plan.ProductId);
                // get order - musts be new query
                if (plan.OrderId != null)
                    plan.Order = GetOrder(connection, (int)plan.OrderId);
            }

            return plan;
        }

        private List<Plan> GetPlans(OracleConnection connection, RecordInfo info)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select count(*) from tis_plan p, tis_vyrobek v" +
                                " where p.vyrobek_id = v.vyrobek_id order by datum_vytvoreni desc";
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                info.Total = reader.GetInt32(0);

            reader.Close();
            cmd.Dispose();

            List<Plan> plans = new List<Plan>();

            cmd = connection.CreateCommand();
            cmd.CommandText = "select * from " +
                                "(select rownum rn, p.*, v.nazev, v.cena, v.narocnost, v.aktivni" +
                                " from tis_plan p, tis_vyrobek v" +
                                " where p.vyrobek_id = v.vyrobek_id order by datum_vytvoreni desc)" +
                                " where rn >= :1 and rn < :2";
            cmd.Parameters.Add(GetNumber(":1", info.Start));
            cmd.Parameters.Add(GetNumber(":2", info.Start + info.Count));
            reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Nullable<int> orderId = null;
                if (!reader.IsDBNull(3))
                    orderId = reader.GetInt32(3);
                Nullable<int> productionLineId = null;
                if (!reader.IsDBNull(4))
                    productionLineId = reader.GetInt32(4);
                Nullable<DateTime> dateStart = null;
                if (!reader.IsDBNull(6))
                    dateStart = reader.GetDateTime(6);
                Nullable<DateTime> dateEnd = null;
                if (!reader.IsDBNull(7))
                    dateEnd = reader.GetDateTime(7);
                Plan plan = GetPlan(reader.GetInt32(1), reader.GetInt32(2), orderId, productionLineId,
                    reader.GetDateTime(5), dateStart, dateEnd, reader.GetInt32(8), reader.GetString(9));
                plan.Product = GetProduct(reader.GetInt32(2), reader.GetString(10), reader.GetDouble(11), reader.GetDouble(12), reader.GetInt32(13));
                plans.Add(plan);
            }

            reader.Close();
            cmd.Dispose();

            return plans;
        }

        #endregion

        #region store

        private List<Item> GetStoreItems(OracleConnection connection, RecordInfo info)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select count(*) from " +
                                "(select v.vyrobek_id from  tis_sklad s, tis_vyrobek v" +
                                " where s.vyrobek_id = v.vyrobek_id group by v.vyrobek_id, v.nazev)";
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                info.Total = reader.GetInt32(0);

            reader.Close();
            cmd.Dispose();

            List<Item> items = new List<Item>();

            cmd = connection.CreateCommand();
            cmd.CommandText = "select * from " +
                                "(select rownum rn, s.* from " +
                                    "(select v.vyrobek_id, v.nazev, sum(s.pocet)" +
                                    " from tis_sklad s, tis_vyrobek v" +
                                    " where s.vyrobek_id = v.vyrobek_id group by v.vyrobek_id, v.nazev)" +
                                "s) where rn >= :1 and rn < :2";
            cmd.Parameters.Add(GetNumber(":1", info.Start));
            cmd.Parameters.Add(GetNumber(":2", info.Start + info.Count));
            reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                items.Add(new Item
                {
                    ProductId = reader.GetInt32(1),
                    Product = GetProduct(reader.GetInt32(1), reader.GetString(2), 0, 0, 1),
                    Count = reader.GetInt32(3)
                });
            }

            reader.Close();
            cmd.Dispose();

            return items;
        }

        #endregion

        #region user / login

        private void NewUser(OracleConnection connection, string name, string password, string role, Nullable<int> customerId)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "insert into tis_uzivatel (jmeno,heslo,uloha,zakaznik_id) values(:1,:2,:3,:4)";
            cmd.Parameters.Add(GetNVarChar(":1", name));
            cmd.Parameters.Add(GetNVarChar(":2", GetPasswordHash(password)));
            cmd.Parameters.Add(GetNVarChar(":3", role));
            cmd.Parameters.Add(GetNumber(":4", customerId));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private void UpdateUser(OracleConnection connection, string name, string password)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "update tis_uzivatel set password = :1 where jmeno = :2";
            cmd.Parameters.Add(GetNVarChar(":1", GetPasswordHash(password)));
            cmd.Parameters.Add(GetNVarChar(":2", name));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private void DeleteUser(OracleConnection connection, string name)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "delete from tis_uzivatel where jmeno = :1";
            cmd.Parameters.Add(GetNVarChar(":1", name));
            cmd.CommandType = CommandType.Text;
            cmd.ExecuteNonQuery();

            cmd.Dispose();
        }

        private User AuthorizeUser(OracleConnection connection, string name, string password)
        {
            User user = null;

            // select record from table
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select * from tis_uzivatel where jmeno = :1";
            cmd.Parameters.Add(GetNVarChar(":1", name));
            OracleDataReader reader = cmd.ExecuteReader();

            string passwordDb = null;
            if (reader.Read())
            {
                passwordDb = reader.GetString(1);

                Nullable<int> customerId = null;
                if (!reader.IsDBNull(3))
                    customerId = reader.GetInt32(3);
                user = GetUser(name, reader.GetString(2), customerId);
            }

            reader.Close();
            cmd.Dispose();

            if (GetPasswordHash(password) == passwordDb)
            {
                if (user.Role == Role.Zakaznik)
                    user.Customer = GetCustomer(connection, user.CustomerId);
            }
            else
                user = null;

            return user;
        }

        private User GetUser(OracleConnection connection, string name)
        {
            User user = null;

            // select record from table
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select * from tis_uzivatel where jmeno = :1";
            cmd.Parameters.Add(GetNVarChar(":1", name));
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                Nullable<int> customerId = null;
                if (!reader.IsDBNull(3))
                    customerId = reader.GetInt32(3);
                user = GetUser(name, reader.GetString(2), customerId);
            }

            reader.Close();
            cmd.Dispose();

            if (user.Role == Role.Zakaznik)
                user.Customer = GetCustomer(connection, user.CustomerId);

            return user;
        }

        private List<User> GetUsers(OracleConnection connection, RecordInfo info)
        {
            OracleCommand cmd = connection.CreateCommand();
            cmd.CommandText = "select count(*) from tis_uzivatel";
            OracleDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
                info.Total = reader.GetInt32(0);

            reader.Close();
            cmd.Dispose();

            List<User> users = new List<User>();

            // select record from table
            cmd = connection.CreateCommand();
            cmd.CommandText = "select * from (select rownum rn, u.* from tis_uzivatel u) where rn >= :1 and rn < :2";
            cmd.Parameters.Add(GetNumber(":1", info.Start));
            cmd.Parameters.Add(GetNumber(":2", info.Start + info.Count));
            reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                Nullable<int> customerId = null;
                if (!reader.IsDBNull(4))
                    customerId = reader.GetInt32(4);
                users.Add(GetUser(reader.GetString(1), reader.GetString(3), customerId));
            }

            reader.Close();
            cmd.Dispose();

            foreach (User user in users)
                if (user.Role == Role.Zakaznik)
                    user.Customer = GetCustomer(connection, user.CustomerId);

            return users;
        }

        #endregion

        #endregion

        #region public methods

        #region customer

        public Customer NewCustomer(string name, string street, int number, string city, int psc, string phone)
        {
            Customer customer = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // insert record to table
                InsertCustomer(connection, name, street, number, city, psc, phone);
                // read record from table
                customer = GetCustomer(connection, name, street, number, city, psc, phone);
            }
            return customer;
        }

        public void UpdateCustomer(Customer newCustomer, Customer oldCustomer)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // update record in table
                UpdateCustomer(connection, newCustomer, oldCustomer);
            }
        }

        public void DeleteCustomer(Customer customer)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // delete record from table
                DeleteCustomer(connection, customer);
            }
        }

        public List<Customer> GetCustomers(RecordInfo info)
        {
            List<Customer> customers;
            using(OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select records from table
                customers = GetCustomers(connection, info);
            }
            return customers;
        }

        #endregion

        #region product

        public Product NewProduct(string name, double price, double timeConsuming)
        {
            Product product = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // insert record to table
                InsertProduct(connection, name, price, timeConsuming);
                // read record from table
                product = GetProduct(connection, name);
            }
            return product;
        }

        public void UpdateProduct(Product newProduct, Product oldProduct)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // update record in table
                UpdateProduct(connection, newProduct, oldProduct);
            }
        }

        public void DeleteProduct(Product product)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // delete record from table
                DeleteProduct(connection, product);
            }
        }

        public List<Product> GetProducts(RecordInfo info)
        {
            List<Product> products;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select records from table
                products = GetProducts(connection, info);
            }
            return products;
        }

        #endregion

        #region production line

        public ProductionLine NewProductionLine(string name, int capacity, double efficiency)
        {
            ProductionLine productionLine = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // insert record to table
                InsertProductionLine(connection, name, capacity, efficiency);
                // read record from table
                productionLine = GetProductionLine(connection, name);
            }
            return productionLine;
        }

        public void UpdateProductionLine(ProductionLine newLine, ProductionLine oldLine)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // update record in table
                UpdateProductionLine(connection, newLine, oldLine);
            }
        }

        public void DeleteProductionLine(ProductionLine line)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // delete record from table
                DeleteProductionLine(connection, line);
            }
        }

        public List<ProductionLine> GetProductionLines(RecordInfo info)
        {
            List<ProductionLine> productionLines;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select records from table
                productionLines = GetProductionLines(connection, info);
            }
            return productionLines;
        }

        #endregion

        #region order item

        public Item NewItem(Order order, Product product, int count)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // insert record to table
                InsertItem(connection, order, product, count);
            }
            return new Item
            {
                OrderId = order.Id,
                Order = order,
                ProductId = product.Id,
                Product = product,
                Count = count
            };
        }

        public void UpdateItem(Item item)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // update record in table
                UpdateItem(connection, item);
            }
        }

        public void DeleteItem(Item item)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // delete record from table
                DeleteItem(connection, item);
            }
        }

        public List<Item> GetItems(Order order)
        {
            List<Item> itemList = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select records from table
                itemList = GetItems(connection, order);
            }
            return itemList;
        }

        #endregion

        #region order

        public Order NewOrder(Customer customer)
        {
            Order order = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // insert record to table
                int orderId = NewOrder(connection, customer);
                // select record from table
                order = GetOrder(connection, orderId);
            }
            return order;
        }

        public Order AcceptOrder(Order order)
        {
            Order acceptedOrder = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // update record in table
                AcceptOrder(connection, order);
                // select record from table
                acceptedOrder = GetOrder(connection, order.Id);
            }
            return acceptedOrder;
        }

        public void CancelOrder(Order order)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // delete record from table
                CancelOrder(connection, order);
            }
        }

        public void SendOrder(Order order)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // update record in table
                SendOrder(connection, order);
            }
        }

        public List<Order> GetOrders(RecordInfo info)
        {
            List<Order> orderList = new List<Order>();
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select records from table
                orderList = GetOrders(connection, info);
            }
            return orderList;
        }

        public List<Order> GetOrders(Customer customer, RecordInfo info)
        {
            List<Order> orderList = new List<Order>();
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select records from table
                orderList = GetOrders(connection, customer, info);
            }
            return orderList;
        }

        public double GetOrderTotalPrice(Order order)
        {
            double total = 0;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select record from table
                total = GetOrderTotalPrice(connection, order.Id);
            }
            return total;
        }

        #endregion

        #region production

        public Plan ProductionStart(ProductionLine line)
        {
            Plan plan = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // update record in table
                Nullable<int> planId = ProductionStart(connection, line);
                if (planId != null)
                    plan = GetPlan(connection, (int)planId);
            }
            return plan;
        }

        public void ProductionEnd(ProductionLine line)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // update record in table
                ProductionEnd(connection, line);
            }
        }

        #endregion

        #region plan

        public Plan GetProductionLinePlan(ProductionLine line)
        {
            Plan plan = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select record from table
                plan = GetProductionLinePlan(connection, line);
            }
            return plan;
        }

        public List<Plan> GetPlans(RecordInfo info)
        {
            List<Plan> plans;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select records from table
                plans = GetPlans(connection, info);
            }
            return plans;
        }

        #endregion

        #region store

        public List<Item> GetStore(RecordInfo info)
        {
            List<Item> items = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select records from table
                items = GetStoreItems(connection, info);
            }
            return items;
        }

        #endregion

        #region user - login

        public User NewUser(string name, string password, Role role, Nullable<int> customerId)
        {
            User user = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // insert record to table
                if (role != Role.Zakaznik)
                    customerId = null;
                NewUser(connection, name, password, role.ToString(), customerId);
                // read record from table
                user = GetUser(connection, name);
            }
            return user;
        }

        public void UpdateUser(string name, string password)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // update record in table
                UpdateUser(connection, name, password);
            }
        }

        public void DeleteUser(string name)
        {
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // delete record from table
                DeleteUser(connection, name);
            }
        }

        public User AuthorizeUser(string name, string password)
        {
            User user = null;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // read record from table
                user = AuthorizeUser(connection, name, password);
            }
            return user;
        }

        public List<User> GetUsers(RecordInfo info)
        {
            List<User> users;
            using (OracleConnection connection = new OracleConnection(connectionString))
            {
                if (connection.State != ConnectionState.Open)
                    connection.Open();
                // select records from table
                users = GetUsers(connection, info);
            }
            return users;
        }

        #endregion

        #endregion
    }
}

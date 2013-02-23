using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Basho
{
    public interface IDataConnection
    {
        // methods supporting application user
        User NewUser(string name, string password, Role role, Nullable<int> customerId);
        void UpdateUser(string name, string password);
        void DeleteUser(string name);
        User AuthorizeUser(string name, string password);
        List<User> GetUsers(RecordInfo info);

        // methods supporting customer table
        Customer NewCustomer(string name, string street, int number, string city, int psc, string phone);
        void UpdateCustomer(Customer newCustomer, Customer oldCustomer);
        void DeleteCustomer(Customer customer);
        List<Customer> GetCustomers(RecordInfo info);

        // methods supporting product table
        Product NewProduct(string name, double price, double timeConsuming);
        void UpdateProduct(Product newProduct, Product oldProduct);
        void DeleteProduct(Product product);
        List<Product> GetProducts(RecordInfo info);

        // methods supporting production line table
        ProductionLine NewProductionLine(string name, int capacity, double efficiency);
        void UpdateProductionLine(ProductionLine newLine, ProductionLine oldLine);
        void DeleteProductionLine(ProductionLine line);
        List<ProductionLine> GetProductionLines(RecordInfo info);

        // methods supporting order's item table
        Item NewItem(Order order, Product product, int count);
        void UpdateItem(Item item);
        void DeleteItem(Item item);
        List<Item> GetItems(Order order);

        // methods supporting order
        Order NewOrder(Customer customer);
        Order AcceptOrder(Order order);
        void CancelOrder(Order order);
        void SendOrder(Order order);
        List<Order> GetOrders(RecordInfo info);
        List<Order> GetOrders(Customer customer, RecordInfo info);
        double GetOrderTotalPrice(Order order);

        // methods supporting production
        Plan ProductionStart(ProductionLine line);
        void ProductionEnd(ProductionLine line);
        Plan GetProductionLinePlan(ProductionLine line);
        List<Plan> GetPlans(RecordInfo info);

        // methods supporting store
        List<Item> GetStore(RecordInfo info);
    }
}

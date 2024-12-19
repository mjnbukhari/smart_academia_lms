class APIUrls {

  static const _ip = "192.168.18.240";
  static const _port = ":5001";
  static const baseUrl = "http://$_ip$_port";
  static const _baseApisUrl = "$baseUrl/api/v1";
  
  // Auth
  static const studentLogin = "$_baseApisUrl/student/login";

  // Student Details
  static const studentDetails = "$_baseApisUrl/student";

  // Update Parent
  static const updateParent = "$_baseApisUrl/student/parent/update";


  // Products
  static const category = "$_baseApisUrl/api_get_cat.php";
  static const products = "$_baseApisUrl/api_get_product.php";
  static const searchProducts = "$_baseApisUrl/api_get_product.php";
  static const sellProducts = "$_baseApisUrl/api_get_sales_product.php";

  // Orders
  static const addOrder = "$_baseApisUrl/api_order_add.php";
  static const shippingAmount = "$_baseApisUrl/api_get_shipping.php";
  static const shippingAmmount = "$_baseApisUrl/api_get_shipping.php";
  static const getOrders = "$_baseApisUrl/api_order_detail.php";
  static const orderProductDetails = "$_baseApisUrl/api_order_product_detail.php";

  // Notifications
  static const notificationUpdateKey = "$_baseApisUrl/api_notification_key.php";

  //HelpLine Submit
  static const helpLineSubmitUrl = "$_baseApisUrl/";

  //deliveryAddress
  static const deliveryAddress = "$_baseApisUrl/api_customer_update.php";
}

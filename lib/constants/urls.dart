//API
import 'package:flutter/material.dart';

const String BASE_URL = 'https://gluconeogenic-conde.000webhostapp.com';
const String REGISTER_URL = '$BASE_URL/register.php';
const String LOGIN_URL = '$BASE_URL/login.php';
const String UPLOAD_URL = '$BASE_URL/add_product.php';
const String READPRODUCT_URL = '$BASE_URL/display.php';
const String ADDTOCART_URL = '$BASE_URL/addCart.php';
const String FETCHCART_URL = '$BASE_URL/fetchCart.php';
const String FETCHCATEGORY_URL = '$BASE_URL/fetchCategory.php';
const String ORDER_URL = '$BASE_URL/orders.php';
const String FETCHORDER_URL = '$BASE_URL/fetchOrder.php';
const String FETCHUSER_URL = '$BASE_URL/fetchUser.php';
const String VERIFIYUSER_URL = '$BASE_URL/verifyUser.php';
const String UPDATEUSER_URL = '$BASE_URL/updateUser.php';
const String DELETECART_URL = '$BASE_URL/deleteCart.php';
const String DELETE_URL = '$BASE_URL/delete.php';

//admin controll url
const String VERIFIYPRODUCT_URL = '$BASE_URL/productToVerify.php';
const String APPROVEPRODUCT_URL = '$BASE_URL/productApproved.php';
const String DECLINEPRODUCT_URL = '$BASE_URL/productDeclined.php';
const String FETCHALLORDER_URL = '$BASE_URL/fetchAllOrder.php';
const String FETCHDELIVEREDORDER_URL = '$BASE_URL/fetchDeliveredOrder.php';
const String FETCHDISPATCEDORDER_URL = '$BASE_URL/fetchDispatchedOrder.php';
const String UPDATEORDERSTATUS_URL = '$BASE_URL/updateOrderStatus.php';
import Vue from "vue";
import VueRouter from "vue-router";
import Order from "../views/Order.vue";
import Address from "../views/Address";
import Menu from "../views/Menu";
import Delivery from "../views/Delivery";
import Store from "../views/Store";
import BuyItem from "../views/Buy";
import Manager from "../views/Manager";
import UserRe from "../views/UserRe";
import Log from "../views/Log"

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "addOrder",
    component: Order
  },
  {
    path: "/adduser",
    name: "adduser",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/AddUsers.vue")
  },
  {
    path: "/add_address",
    name: "add_address",
    component: Address
  },
  {
    path: "/add_to_menu",
    name: "AddToMenu",
    component: Menu
  },
  {
    path: "/add_to_delivery",
    name: "add_to_delivery",
    component: Delivery
  },
  {
    path: "/buy_item",
    name: "buy",
    component: BuyItem
  },
  {
    path: "/add_store",
    name: "AddStore",
    component: Store
  },
  {
    path: "/report/manager",
    name: "ManagerReport",
    component: Manager
  },
  {
    path: "/report/user",
    name: "Userrrrr",
    component: UserRe
  },
  {
    path: "/log",
    name: "LogIt",
    component: Log
  }
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes
});

export default router;

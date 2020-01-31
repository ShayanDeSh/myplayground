<template>
  <div id="app">
    <div id="nav">
      <router-link to="/">New Order</router-link> |
      <router-link to="/adduser">Add User</router-link>|
      <router-link to="/add_address">Add Address</router-link>|
      <router-link to="/add_to_menu">Add Menu Item</router-link>|
      <router-link to="/add_to_delivery">Add Delivery man</router-link>|
      <router-link to="/add_store">Add Store</router-link>|
      <router-link to="/buy_item">Buy From Store</router-link>|
      <router-link to="/report/user">User Report</router-link>|
      <router-link to="/report/manager">Manager Report</router-link>|
      <router-link to="/log">Logs</router-link>
    </div>
    <router-view />
  </div>
</template>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>

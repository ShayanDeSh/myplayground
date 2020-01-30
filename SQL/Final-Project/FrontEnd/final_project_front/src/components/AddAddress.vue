<template>
    <div class="container">
        <div style="width: 75%; margin: auto">
            <div style="padding-left: 50px">
                <div class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>personal_id</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="personal_id" name="" type="text"/>
                    </div>
                </div>
                <div class="item" style="width: 100%">
                    <div style="width: 25%; display: inline-block;">
                        <label>landline</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="landline" name="" type="text"/>
                    </div>
                </div>
                <div class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>address name</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="address_name" name="" type="text"/>
                    </div>
                </div>
                <div class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>address</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="address" name="" type="text"/>
                    </div>
                </div>
            </div>
            <input v-on:click="send" value="Submit" style="margin-top: 20px; width: 100%" type="button">
        </div>
    </div>
</template>

<script>
  export default {
    name: "AddAddress",
    data() {
      return {
        personal_id: null,
        landline: null,
        address: null,
        address_name: null
      };
    },
    methods: {
      send() {
        this.$http.post(
          "http://127.0.0.1:9090/users/address/insert/",
          JSON.stringify({
            personal_id: this.personal_id,
            landline: this.landline,
            address: this.address,
            address_name: this.address_name
          })
          , {
            headers: {
              "Content-Type": "application/json"
            }
          }
        );
      }
    }
  };
</script>

<style scoped>


    .container {
        border: 5px solid;
        margin-left: 25%;
        margin-right: 25%;
        padding-bottom: 10px;
        background: #64818c;
        border-radius: 4px;
        display: block;
        border-color: #64818c;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    }

    input[type="text"],
    select,
    textarea {
        width: 50%;
        padding: 12px;
        border: 1px solid #c7d7d9;
        border-radius: 4px;
        resize: vertical;
    }

    .item {
        display: block;
        margin-top: 20px
    }

    label {
        color: #C7D7D9;
        margin-top: 2px;
        font-size: 25px;
        width: 20%;
    }

    input[type=button] {
        width: 100%;
        background-color: #e9f1f2;
        color: #64818c;
        padding: 14px 20px;
        margin: 8px 0;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
</style>
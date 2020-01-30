<template>
    <div class="container">
        <div style="width: 75%; margin: auto">
            <div style="padding-left: 50px">
                <div class="item" style="width: 100%">
                    <div style="width: 25%; display: inline-block;">
                        <label>personal id</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="personal_id" name="" type="text"/>
                    </div>
                </div>
                <div class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>address id</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="address_id" name="" type="text"/>
                    </div>
                </div>
                <div class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>delivery id</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="delivery_id" name="" type="text"/>
                    </div>
                </div>
                <div v-bind="key" v-for="(item, index) in items" :key="index" class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>item name</label>
                    </div>
                    <div style="width: 75%; display: inline-block;">
                        <input v-model="item.item_name" type="text"/>
                    </div>
                </div>
            </div>
            <div>
                <input v-on:click="add" value="Add"
                       style="margin-top: 30px; width: 20%; background: #58dc88; color: white" type="button">
                <input v-on:click="del" value="delete"
                       style="margin-top: 30px; margin-left: 10px; width: 20%; background: #ff5456; color: white"
                       type="button">

            </div>
            <input v-on:click="send" value="Submit" style="margin-top: 0px; width: 100%" type="button">
        </div>
    </div>
</template>

<script>

  export default {
    name: "AddOrder",
    props: {
      msg: String
    },
    data() {
      return {
        x: 1,
        personal_id: null,
        delivery_id: null,
        address_id: null,
        items: [{ item_name: "", number: 1 }]
      };
    },
    methods: {
      add() {
        this.x++;
        this.items.push({ item_name: "", number: 1 });
      },
      del() {
        if (this.x > 1) {
          this.items.pop();
          this.x--;
        }
      },
      send() {
        if (this.delivery_id.empty()) {
          this.delivery_id = null;
        }
        if (this.address_id.empty()) {
          this.address_id = null;
        }
        this.$http.post(
          "http://127.0.0.1:9090/restaurant/orders/insert",
          JSON.stringify({
            personal_id: this.personal_id,
            address_id: this.address_id,
            delivery_id: this.delivery_id,
            items: this.items
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

<!-- Add "scoped" attribute to limit CSS to this component only -->
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
        font-size: 1rem;
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

<template>
    <div class="container">
        <div style="width: 75%; margin: auto">
            <div style="padding-left: 50px">
                <div class="item" style="width: 100%">
                    <div style="width: 25%; display: inline-block;">
                        <label>store id</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <select  v-model="store_id">
                            div :id="val"
                            <option v-for="(store, index) in stores" :key="index" :id="store.store_id">{{store.store_id}}</option>
                        </select>
                        <!--<input v-model="personal_id" name="" type="text"/>-->
                    </div>
                </div>
                <div v-bind="key" v-for="(item, index) in items" :key="index" class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>item name</label>
                    </div>
                    <div style="width: 75%; display: inline-block;">
                        <input v-model="item.item_name" type="text"/>
                    </div>
                    <div style="margin-top: 5px">
                        <div style="width: 25%; display: inline-block;">
                            <label>price</label>
                        </div>
                        <div style="width: 75%; display: inline-block;">
                            <input v-model="item.price" type="text"/>
                        </div>
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
    name: "BuyItem",
    props: {
      msg: String
    },
    data() {
      return {
        x: 1,
        store_id: null,
        stores: [],
        items: [{ item_name: "", price: 0 }]
      };
    },
    mounted () {
      this.$http
        .get('http://127.0.0.1:9090/restaurant/stores/get')
        .then(response => {
          this.stores = response.data.stores;
        })
    }
    ,
    methods: {
      add() {
        this.x++;
        this.items.push({ item_name: "", price: 0 });
      },
      del() {
        if (this.x > 1) {
          this.items.pop();
          this.x--;
        }
      },
      send() {
        this.$http.post(
          "http://127.0.0.1:9090/restaurant/buy/insert",
          JSON.stringify({
            items: this.items,
            store_id: this.store_id
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

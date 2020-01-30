<template>
    <div class="container">
        <div style="width: 75%; margin: auto">
            <div style="padding-left: 50px">
                <div class="item" style="width: 100%">
                    <div style="width: 25%; display: inline-block;">
                        <label>item name</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="item_name" name="" type="text"/>
                    </div>
                </div>
                <div class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>current price</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="current_price" name="" type="text"/>
                    </div>
                </div>
            </div>
            <input
                    @click="send"
                    value="Send"
                    style="margin-top: 20px; width: 30%; margin-right: 3px;"
                    type="button"
            />
            <input
                    @click="update"
                    value="Update"
                    style="margin-top: 20px; width: 30%; margin-right: 3px"
                    type="button"
            />
            <input @click="deletei" value="Delete" style="margin-top: 20px; width: 30%;" type="button"/></div>
    </div>
</template>

<script>
  export default {
    name: "AddMenuItem",
    data() {
      return {
        item_name: null,
        current_price: null
      };
    },
    methods: {
      send() {
        this.$http.post(
          "http://127.0.0.1:9090/restaurant/menu/insert",
          JSON.stringify({
            item_name: this.item_name,
            current_price: this.current_price
          })
          , {
            headers: {
              "Content-Type": "application/json"
            }
          }
        );
      },
      update() {
        this.$http.put(
          "http://127.0.0.1:9090/restaurant/menu/update",
          JSON.stringify({
            item_name: this.item_name,
            current_price: this.current_price
          })
          , {
            headers: {
              "Content-Type": "application/json"
            }
          }
        );
      },
      deletei() {
        this.$http.delete(
          "http://127.0.0.1:9090/restaurant/menu/delete",
          {
            data:
              {
                item_name: this.item_name
              }
          }
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
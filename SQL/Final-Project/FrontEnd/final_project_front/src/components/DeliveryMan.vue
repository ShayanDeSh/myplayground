<template>
    <div class="container">
        <div style="width: 75%; margin: auto">
            <div style="padding-left: 50px">
                <div class="item" style="width: 100%">
                    <div style="width: 25%; display: inline-block;">
                        <label>delivery id</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="delivery_id" name type="text"/>
                    </div>
                </div>
                <div class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>first name</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="first_name" name type="text"/>
                    </div>
                </div>
                <div class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>last name</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="last_name" name type="text"/>
                    </div>
                </div>
                <div class="item">
                    <div style="width: 25%; display: inline-block;">
                        <label>phone number</label>
                    </div>
                    <div style="width: 75% ; display: inline-block;">
                        <input v-model="phone_number" name type="text"/>
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
            <input @click="deletei" value="Delete" style="margin-top: 20px; width: 30%;" type="button"/>
        </div>
    </div>
</template>

<script>
  export default {
    name: "delivery_man",
    data() {
      return {
        delivery_id: null,
        first_name: null,
        last_name: null,
        phone_number: null
      };
    },
    methods: {
      send() {
        this.$http.post(
          "http://127.0.0.1:9090/restaurant/delivery/insert",
          JSON.stringify({
            delivery_id: this.delivery_id,
            first_name: this.first_name,
            last_name: this.last_name,
            phone_number: this.phone_number
          }),
          {
            headers: {
              "Content-Type": "application/json"
            }
          }
        );
      },
      update() {
        this.$http.put(
          "http://127.0.0.1:9090/restaurant/delivery/update",
          JSON.stringify({
            delivery_id: this.delivery_id,
            first_name: this.first_name,
            last_name: this.last_name,
            phone_number: this.phone_number
          }),
          {
            headers: {
              "Content-Type": "application/json"
            }
          }
        );
      },
      deletei() {
        this.$http.delete(
          "http://127.0.0.1:9090/restaurant/delivery/delete",
          {
            data: {
              delivery_id: this.delivery_id
            }
          },
          {
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
        margin-top: 20px;
    }

    label {
        color: #c7d7d9;
        margin-top: 2px;
        font-size: 1rem;
        width: 20%;
    }

    input[type="button"] {
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
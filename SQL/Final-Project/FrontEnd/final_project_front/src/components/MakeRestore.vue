<template>
    <div>
        <div class="container">
            <div style="width: 75%; margin: auto">
                <div style="padding-left: 50px">
                    <div class="item" style="width: 100%">
                        <div style="width: 25%; display: inline-block;">
                            <label>table_name</label>
                        </div>
                        <div style="width: 75% ; display: inline-block;">
                            <input type="text" v-model="table_name"/>
                        </div>
                    </div>
                    <input @click="send" type="button" value="Execute">
                </div>
            </div>
        </div>
    </div>
</template>

<script>
  export default {
    name: "MakeRestore",
    data() {
      return {
        table_name: null
      };
    },
    methods: {
      send() {
        this.$http.get(
          "http://127.0.0.1:9090/users/restore/" + this.table_name
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
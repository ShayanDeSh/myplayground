<template>
    <div>
        <div class="container">
            <div style="width: 75%; margin: auto">
                <div style="padding-left: 50px">
                    <div class="item" style="width: 100%">
                        <div style="width: 25%; display: inline-block;">
                            <label>personal id</label>
                        </div>
                        <div style="width: 75% ; display: inline-block;">
                            <input v-model="personal_id" type="text"/>
                        </div>
                    </div>
                    <input @click="getData" type="button" value="Get Data">
                </div>
            </div>
        </div>

        <div v-if="report != null" class="container" style="margin-top: 10px">
            <div style="width: 75%; margin: auto">
                <div style="padding-left: 50px">
                    <div class="item" style="width: 100%">
                        <div style="width: 25%; display: inline-block;">
                            <label>favorite item</label>
                        </div>
                        <div style="width: 75% ; display: inline-block;">
                            <input disabled :value="report.favorite.item_name" type="text"/>
                        </div>
                    </div>
                    <div class="item" style="width: 100%">
                        <div style="width: 25%; display: inline-block;">
                            <label>number of repetition</label>
                        </div>
                        <div style="width: 75% ; display: inline-block;">
                            <input disabled :value="report.favorite.repetition" type="text"/>
                        </div>
                    </div>
                    <div class="item" style="width: 100%">
                        <div style="width: 25%; display: inline-block;">
                            <label>total price</label>
                        </div>
                        <div style="width: 75% ; display: inline-block;">
                            <input disabled :value="report.total_price" type="text"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div v-if="report != null">
            <div v-for="(factor, index) in report.factors" :key="index"
                 style="margin-top: 10px; padding-bottom: 15px"
                 class="container">
                <div style="width: 75%; margin: auto">
                    <div style="padding-left: 50px">
                        <div class="item" style="width: 100%">
                            <div style="width: 25%; display: inline-block;">
                                <label>Factor Id</label>
                            </div>
                            <div style="width: 75% ; display: inline-block;">
                                <input disabled :value="factor.factor_id" type="text"/>
                            </div>
                        </div>
                        <div class="item" style="width: 100%">
                            <div style="width: 25%; display: inline-block;">
                                <label>Date</label>
                            </div>
                            <div style="width: 75% ; display: inline-block;">
                                <input disabled :value="factor.date" type="text"/>
                            </div>
                        </div>

                        <div class="item" style="width: 100%">
                            <div style="width: 25%; display: inline-block;">
                                <label>Item name</label>
                            </div>
                            <div style="width: 75% ; display: inline-block;">
                                <input disabled :value="factor.item_name" type="text"/>
                            </div>
                        </div>


                        <div class="item" style="width: 100%">
                            <div style="width: 25%; display: inline-block;">
                                <label>Price</label>
                            </div>
                            <div style="width: 75% ; display: inline-block;">
                                <input disabled :value="factor.price" type="text"/>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</template>

<script>
  export default {
    name: "UserReport",
    data() {
      return {
        personal_id: null,
        report: null
      };
    },
    methods: {
      getData() {
        this.$http.get("http://127.0.0.1:9090/users/report/" +
          this.personal_id)
          .then(response => {
            this.report = response.data;
            console.log(this.report);
          });
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
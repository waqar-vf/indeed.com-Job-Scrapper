console.log("Custom js is working")
alert("000000")
function show_waiting_bar(){
    $("#waiting_bar").modal("show")
}
function get_batch (obj){
    id = $(obj).val()
    window.top.location.href = "/"+id
}
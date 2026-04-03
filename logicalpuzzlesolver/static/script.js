function hideAll() {
    document.getElementById("inputPanel").style.display = "none";
    document.getElementById("outputPanel").style.display = "none";
    document.getElementById("reasonPanel").style.display = "none";
}

function showInput() {
    hideAll();
    document.getElementById("inputPanel").style.display = "block";
}

function showOutput() {
    hideAll();
    document.getElementById("outputPanel").style.display = "block";
}

function showReason() {
    hideAll();
    document.getElementById("reasonPanel").style.display = "block";
}
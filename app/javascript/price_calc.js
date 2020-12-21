window.addEventListener('load', () => {

  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitFee = document.getElementById("profit");
  
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    console.log(inputValue);
    
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
    console.log(addTaxDom.innerHTML);

    const charge = addTaxDom.innerHTML;
    profitFee.innerHTML = Math.floor(inputValue - charge);
    console.log(profitFee.innerHTML);
    })
});


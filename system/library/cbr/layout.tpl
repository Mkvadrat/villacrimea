{root:}
{data.data:info}
{info:}
	<div style="background-size:cover; background-image:url(/-cbr/images/money.jpg)">
		<div style="padding:10px; background-color:rgba(255, 255, 255, 0.8)">
			<div style="font-size:150%;">Курсы валют</div>
				На {~date(:j F Y,date)} года
			<div>
				USD/RUB <b>{~cost(list.USD.value)} руб.</b>
			</div>
			<div>
				EUR/RUB <b>{~cost(list.EUR.value)} руб.</b>
			</div>
		</div>
	</div>
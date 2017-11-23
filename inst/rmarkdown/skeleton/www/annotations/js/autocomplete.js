<script>
/* =============================================================
 * autocomplete.js 
 * =============================================================
 * Copyright 2017
 *
 * IMPORTANT!
 * When you add a new person to the list, follow the instructors:
 * - in name argument, please write first name and last name together e.g.
 * MikolajBogucki. It is not visible on the browser, but we use it as a identifier.
 * - in username argument, please put an email of new person.
 * ============================================================ */
 
	$(document).ready(function(){
	
		$(".recipient").mention({
		    delimiter: "\\+",
		    delimiter2: "\+",
			users: [{
			    
				name: 'EmiliaPankowska',
				username: 'emilia.pankowska@pearson.com',
			}, {
				name: 'MikolajBogucki',
				username: 'mikolaj.bogucki@pearson.com',
			}, {
				name: 'MikolajOlszewski',
				username: 'mikolaj.olszewski@pearson.com',
			}, {
				name: 'MalgorzataSchimdt',
				username: 'malgorzata.schmidt@pearson.com',
			}, {
				name: 'KrzysztofJedrzejewski',
				username: 'krzysztof.jedrzejewski@pearson.com',
			}, {
				name: 'MateuszOtmianowski',
				username: 'mateusz.otmianiowski@pearson.com',
			}, {
				name: 'KacperLodzikowski',
				username: 'kacper.lodzikowski@pearson.com',
			}]
		});
		
	});
</script>
export default {
	defaultBrowser: 'Choosy',
	rewrite: [
		{
			match: () => true,
			url: url => {
				const u = new URL(url)

				// remove common tracking params
				const paramsToRemove = [
					'dclid',
					'fbclid',
					'gclid',
					'igshid',
					'mc_eid',
					'utm_campaign',
					'utm_content',
					'utm_medium',
					'utm_source',
					'utm_term',
					'yclid',
				]

				paramsToRemove.forEach(p => u.searchParams.delete(p))

				return u.toString()
			},
		},
	],
}

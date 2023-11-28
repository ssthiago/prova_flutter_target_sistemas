module.exports = {
  types: [
    { value: ':sparkles: feat', name: '✨ feat:\tAdiciona nova feature' },
    { value: ':bug: fix', name: '🐛 fix:\tCorrigindo um bug' },
    { value: ':memo: docs', name: '📝 docs:\tAdiciona ou atualiza documentação' },
    {
      value: ':lipstick: style',
      name: '💄 style:\tAdiciona ou atualiza estilos, ui ou ux',
    },
    {
      value: ':recycle: refactor',
      name: '♻️ refactor:\tAlteração de código que não corrige um bug nem adiciona uma feature',
    },
    {
      value: ':zap: perf',
      name: '⚡️ perf:\tMudança de código que melhora o desempenho',
    },
    {
      value: ':white_check_mark: test',
      name: '✅ test:\tAdicionando casos de testes',
    },
    {
      value: ':truck: chore',
      name: '🚚 chore:\tMudanças no processo de compilação ou ferramentas auxiliares\n\t\t e bibliotecas, como geração de documentação',
    },
    { value: ':rewind: revert', name: '⏪️ revert:\tReverter para um commit' },
    { value: ':construction: wip', name: '🚧 wip:\tTrabalho em progresso' },
    {
      value: ':construction_worker: build',
      name: '👷 build:\tAdições ou atualizações em relação ao processo de build do projeto',
    },
    {
      value: ':green_heart: ci',
      name: '💚 ci:\tAdições ou atualizações relacionadas ao processo de integração contínua (CI) do projeto',
    },
  ],

  scopes: [
    { name: 'ui' },
    { name: 'android' },
    { name: 'ios' },
  ],

  scopeOverrides: {
    fix: [{ name: 'merge' }, { name: 'style' }, { name: 'test' }, { name: 'hotfix' }],
  },

  allowCustomScopes: true,
  allowBreakingChanges: ['feat', 'fix'],
  // skip any questions you want
  //skipQuestions: ['body'],
  subjectLimit: 100,
};
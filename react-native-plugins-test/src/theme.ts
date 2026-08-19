import { DefaultTheme, type Theme } from '@react-navigation/native';

export const palette = {
  primary: '#4C6FFF',
  background: '#F4F6FA',
  hero: '#183153',
  text: '#172033',
  muted: '#7A8499',
  border: '#E3E7EF',
  disclosure: '#A6AFBE',
  white: '#FFFFFF',
} as const;

export const navigationTheme: Theme = {
  ...DefaultTheme,
  colors: {
    ...DefaultTheme.colors,
    primary: palette.primary,
    background: palette.background,
    card: palette.background,
    text: palette.text,
    border: palette.border,
  },
};

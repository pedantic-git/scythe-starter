Array.prototype.shuffle = function() {
  let m = this.length, i;
  while (m) {
    i = (Math.random() * m--) >>> 0;
    [this[m], this[i]] = [this[i], this[m]]
  }
  return this;
}

interface Mat {
  name: string,
  index: number,
  ifa?: boolean
}

const mats: Mat[] = [
  {name: 'Industrial', index: 1},
  {name: 'Engineering', index: 2},
  {name: 'Militant', index: 2.1, ifa: true},
  {name: 'Patriotic', index: 3},
  {name: 'Innovative', index: 3.1, ifa: true},
  {name: 'Mechanical', index: 4},
  {name: 'Agricultural', index: 5}
].shuffle()

export const useMats = () => mats

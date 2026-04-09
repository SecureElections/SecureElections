package models

import (
	"strconv"

	. "maragu.dev/gomponents"
	. "maragu.dev/gomponents/html"
)

type File struct {
	Name     string
	Size     int64
	Modified string
}

func (f *File) Render() Node {
	return Tr(
		Td(Text(f.Name)),
		Td(Text(strconv.FormatInt(f.Size, 10))),
		Td(Text(f.Modified)),
	)
}

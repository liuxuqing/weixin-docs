class ExportedDocumentError < Exception; end

raise ExportedDocumentError.new('cannot export invalid or unsaved document')
